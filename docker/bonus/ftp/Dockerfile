FROM alpine:3.22

RUN apk update && apk add --no-cache vsftpd

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN adduser -D -u 88 lflayeux \
	&& echo "lflayeux:test" | chpasswd \ 
	&& echo "lflayeux" >> /etc/vsftpd/user_list

RUN mkdir -p /var/www/html && chown lflayeux:lflayeux /var/www/html

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]