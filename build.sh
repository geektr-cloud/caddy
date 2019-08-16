#!/usr/bin/env bash

docker build \
  --build-arg http_proxy=http://proxy.geektr.co:3128 \
  --build-arg https_proxy=http://proxy.geektr.co:3128 \
  --tag "geektrcloud/caddy:latest" \
  --compress \
  .

tee <<EOF
=========================
docker push geektrcloud/caddy
=========================
EOF
