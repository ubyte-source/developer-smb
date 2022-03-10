FROM amd64/alpine

ENV STARTUP_COMMAND_RUN_SAMBA="smbd -F --no-process-group"

COPY wrapper.sh /

RUN apk --no-cache --no-progress update && \
    apk --no-cache --no-progress add samba samba-client krb5 openntpd samba-winbind samba-winbind-clients cifs-utils && \
    adduser -D -g samba samba && \
    chmod +x wrapper.sh && \
    chown -R samba:samba /var/lib/samba /var/log/samba /var/cache/samba /run/samba

EXPOSE 137/udp 138/udp 139 445

USER samba

ENTRYPOINT /wrapper.sh
