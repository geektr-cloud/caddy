# Source: https://github.com/abiosoft/caddy-docker

#
# Builder
#
FROM abiosoft/caddy:builder as builder

ARG version="1.0.3"
ARG plugins="git,cors,realip,expires,cache,cloudflare,dyndns,cgi,filter,forwardproxy,geoip,grpc,ipfilter,jwt,login,s3browser"
ARG enable_telemetry="true"

# process wrapper
RUN go get -v github.com/abiosoft/parent

RUN VERSION=${version} PLUGINS=${plugins} ENABLE_TELEMETRY=${enable_telemetry} /bin/sh /usr/bin/builder.sh

#
# Final stage
#
FROM alpine:3.10
LABEL maintainer "GeekTR <geektheripper@gmail.com>"

ARG version="1.0.3"
LABEL caddy_version="$version"

# Let's Encrypt Agreement
ENV ACME_AGREE="true"

# Telemetry Stats
ENV ENABLE_TELEMETRY="$enable_telemetry"

RUN apk add --no-cache \
    ca-certificates \
    git \
    mailcap \
    openssh-client \
    tzdata

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

EXPOSE 80 443
WORKDIR /srv

# install process wrapper
COPY --from=builder /go/bin/parent /bin/parent

ENTRYPOINT ["/bin/parent", "caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
