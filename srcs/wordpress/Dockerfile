FROM alpine:3.22

COPY wordpress_init.sh /usr/local/bin/

RUN apk update && apk add --no-cache php-fpm wget php-mysqli php-phar php-iconv php-json php-mbstring php-redis php-tokenizer fcgi php-ctype\
	&& sed -i 's/listen = 127.0.0.1:9000/listen = ${WP_PORT}/g' /etc/php83/php-fpm.d/www.conf \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar \
	&& apk del wget \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& mkdir -p /var/www/html \
	&& chmod +x /usr/local/bin/wordpress_init.sh

EXPOSE ${WP_PORT}

ENTRYPOINT ["wordpress_init.sh"]

CMD ["php-fpm83", "-F"]