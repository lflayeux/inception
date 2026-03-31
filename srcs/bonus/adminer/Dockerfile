FROM alpine:3.22

RUN apk update && apk add --no-cache php php-mysqli php-session wget

WORKDIR /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.2/adminer-5.4.2.php \
	&& mv adminer-5.4.2.php index.php
CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www/html"]