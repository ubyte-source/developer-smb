FROM amd64/alpine:3.14

ARG PASSWORD='Bphu44@3np'

RUN apk --no-cache --no-progress update && \
    apk --no-cache --no-progress add samba  && \
    addgroup -S smb && \
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g 'Samba User' smbuser && \
    echo -e "$PASSWORD\n$PASSWORD" | passwd smbuser

VOLUME ["/etc", "/var/cache/samba", "/var/lib/samba", "/var/log/samba", "/run/samba"]

EXPOSE 137/udp 138/udp 139 445

USER smbuser

ENTRYPOINT ["smbd", "-F", "--no-process-group"]