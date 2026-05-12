#!/bin/sh
set -eu

WP_PATH=/var/www/html
RETRIES=60
DELAY=2

cd "$WP_PATH" || exit 1

for i in $(seq 1 $RETRIES); do
    if wp core is-installed --path="$WP_PATH" --allow-root >/dev/null 2>&1; then
        exit 0
    fi
    sleep "$DELAY"
done

exit 1