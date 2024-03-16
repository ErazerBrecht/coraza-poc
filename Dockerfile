FROM caddy:2.7.6-builder-alpine AS builder
RUN  xcaddy build --with github.com/corazawaf/coraza-caddy/v2

FROM caddy:2.7.6-alpine AS final
RUN  rm -rf /usr/share/caddy/ && apk --update-cache upgrade && find /usr/sbin /usr/bin /sbin /bin -delete -executable -not -iname '*.so*' -a -not -type d
 
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY coraza /opt/coraza/config