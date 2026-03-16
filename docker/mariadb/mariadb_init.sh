#!/bin/sh
set -eu


is_init_db() {
	if [ -d /var/lib/mysql/mysql ]; then
		return 0
	else
		return 1
	fi
}

init_db() {

	DB_ROOT_PASSWORD=$(cat "$DB_PATH_TO_ROOT_PWD")
	DB_USER_PASSWORD=$(cat "$DB_PATH_TO_USER_PWD")
	echo "<=========================================> MariaDB Initialisation <=========================================>"
	mkdir -p /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
	until mariadb-admin ping --silent; do
        sleep 1
    done
	mariadb -u root <<EOF 
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%';
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'localhost';
FLUSH PRIVILEGES;

EOF

	mariadb-admin -u root shutdown
}

main() {

	if is_init_db; then
		echo "<=========================================> MariaDB Already Init<=========================================>"
	else
		init_db
	fi
	exec "$@"
}

main "$@"