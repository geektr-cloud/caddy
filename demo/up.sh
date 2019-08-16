#!/usr/bin/env bash
docker run -it --rm --name caddy -p 80:80 -p 443:443 \
  -v "$PWD/Caddyfile":/etc/Caddyfile:ro \
  -v "$PWD/index.html":/srv/index.html:ro \
  geektrcloud/caddy:latest
