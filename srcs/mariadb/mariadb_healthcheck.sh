#!/bin/sh
set -u
if [ ! -f "${DB_PATH_TO_USER_PWD}" ]; then
    echo "Secret file not found at ${DB_PATH_TO_USER_PWD}"
    exit 1
fi
DB_PASSWORD=$(cat "${DB_PATH_TO_USER_PWD}")

mariadb-admin ping -h localhost -P "${DB_PORT}" -u "${DB_USERNAME}" -p"${DB_PASSWORD}"

exit $?