#!/bin/sh

FTP_PASSWORD=$(cat "$FTP_PATH_TO_PWD")

mkdir -p /etc/vsftpd
mkdir -p /var/log/vsftpd
touch /etc/vsftpd/user_list
touch /var/log/vsftpd/vsftpd.log
chmod 644 /var/log/vsftpd/vsftpd.log

adduser -D -h /var/www/html -s /bin/false -u 88 "$FTP_USERNAME"

echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd \
&& echo "$FTP_USERNAME" >> /etc/vsftpd/user_list
chmod 644 /etc/vsftpd/user_list
chown -R "$FTP_USERNAME":"$FTP_USERNAME" /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf