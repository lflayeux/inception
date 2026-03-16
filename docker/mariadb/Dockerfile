FROM alpine:3.22

COPY mariadb_init.sh /usr/local/bin/
COPY mariadb_healthcheck.sh /usr/local/bin/

RUN	apk add --no-cache mariadb mariadb-client

RUN chmod +x /usr/local/bin/mariadb_init.sh && chmod +x /usr/local/bin/mariadb_healthcheck.sh

ENTRYPOINT ["/usr/local/bin/mariadb_init.sh"]

CMD ["mariadbd", "--user=mysql", "--bind-address=0.0.0.0", "--skip-networking=false"]
