# FROM alpine:3.22

# RUN apk update && apk add --no-cache vsftpd

# COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

# RUN adduser -D -u 88 {FTP_USERNAME} \
# 	&& echo "{FTP_USERNAME}:cat {FTP_PATH_TO_PWD}" | chpasswd \ 
# 	&& echo "{FTP_USERNAME}" >> /etc/vsftpd/user_list

# RUN mkdir -p /var/www/html && chown {FTP_USERNAME}:{FTP_USERNAME} /var/www/html

# CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

FROM alpine:3.22

RUN apk update && apk add --no-cache vsftpd

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./setup_ftp.sh /usr/local/bin/setup_ftp.sh
RUN chmod +x /usr/local/bin/setup_ftp.sh

ENTRYPOINT ["setup_ftp.sh"]