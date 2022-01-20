FROM amd64/alpine:3.14

RUN apk --no-cache --no-progress update && \
    apk --no-cache --no-progress add samba  && \
    adduser -D -g samba samba && \
    chown -R samba:samba /var/lib/samba /var/log/samba /var/cache/samba /run/samba

EXPOSE 137/udp 138/udp 139 445

USER samba

ENTRYPOINT ["smbd", "-F", "--no-process-group"]