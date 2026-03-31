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
	echo "<============================================================================================================>"
	echo "<=========================================> MariaDB Initialisation <=========================================>"
	echo "<============================================================================================================>"
	mkdir -p /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
	pid=$!
	# COUNTDOWN PING
	COUNT=0
	RETRIES=30
	until mariadb-admin ping --silent; do
    	COUNT=$((COUNT + 1))
    
 		if [ $COUNT -ge $RETRIES ]; then
    		echo "Error: MariaDB did not respond after $RETRIES seconds. Exiting."
        	exit 1
   		fi
    	echo "Waiting for MariaDB... ($COUNT/$RETRIES)"
        sleep 1
    done
	mariadb -u root <<EOF 
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%';
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

	mariadb-admin -u root -p${DB_ROOT_PASSWORD} shutdown
	wait $pid
	echo "<========================================================================================================================>"
	echo "<=========================================> MariaDB initial configuration done.<=========================================>"
	echo "<========================================================================================================================>"
}

main() {

	if is_init_db; then
		echo "<=========================================================================================================>"
		echo "<=========================================> MariaDB Already Init<=========================================>"
		echo "<=========================================================================================================>"
	else
		init_db
	fi
	exec mariadbd --user=mysql --port="${DB_PORT}" --bind-address=0.0.0.0 --skip-networking=0
}

main