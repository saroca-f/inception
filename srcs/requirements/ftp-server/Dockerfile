FROM debian:bullseye

RUN apt update -y && apt install -y && apt install vsftpd -y

COPY ./ftp_init.sh /tmp/

CMD [ "bash", "/tmp/ftp_init.sh"]

#CMD [ "usr/sbin/vsftpd", "/etc/vsftpd.conf"]