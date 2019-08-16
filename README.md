# geektrcloud/caddy

```bash
docker run -it --rm --name caddy -p 80:80 -p 443:443 \
  -v "$PWD/demo/Caddyfile":/etc/Caddyfile:ro \
  -v "$PWD/demo/index.html":/srv/index.html:ro \
  geektrcloud/caddy:latest
```
