#!/bin/sh

sed -i "s/REPLACE_BY_PORT/${WP_PORT}/g" /etc/nginx/nginx.conf

exec nginx -g "daemon off;"