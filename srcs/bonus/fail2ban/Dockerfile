FROM alpine:3.22

RUN apk update && apk add --no-cache fail2ban iptables

RUN mkdir -p /var/run/fail2ban 


COPY ./jail.local /etc/fail2ban/jail.d/jail.conf
COPY ./vsftpd-auth.conf /etc/fail2ban/filter.d/vsftpd-auth.conf


CMD [ "fail2ban-server", "-f", "-x", "start" ]

# CMD ["tail", "-f", "/dev/null"]