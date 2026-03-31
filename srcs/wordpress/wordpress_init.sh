#!/bin/sh
set -eu

is_wp_init() {
    if [ ! -f "wp-config.php" ]; then
        return 0
    else
        return 1
    fi
}

init_wp() {
    php -d memory_limit=512M /usr/local/bin/wp core download --allow-root
    
    DB_PASSWORD=$(cat "$DB_PATH_TO_USER_PWD")
    WP_ADMIN_PASSWORD=$(cat "$WP_PATH_TO_ADMIN_PWD")
    WP_USER_PASSWORD=$(cat "$WP_PATH_TO_USER_PWD")

    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USERNAME \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:$DB_PORT  \
        --allow-root

    wp core install \
        --url=lflayeux.42.fr \
        --title="$WEBSITE_NAME" \
        --admin_user=$WP_ADMIN_NAME \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=lflayeux@student.42.fr \
        --skip-email \
        --allow-root

    wp user create $WP_USERNAME \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        lolo@student.42.fr \
        --allow-root
    wp config set WP_DEBUG true --raw --allow-root
    wp config set WP_DEBUG_DISPLAY true --raw --allow-root
}

init_redis() {
    wp plugin install redis-cache --activate --allow-root
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp redis enable --allow-root
}

main() {

    cd /var/www/html
    if is_wp_init; then
        echo "<============================================================================================================>"
		echo "<=========================================> WORDPRESS INSTALLATION <=========================================>"
		echo "<============================================================================================================>"
        init_wp
        init_redis
        chown -R 88:88 /var/www/html
    else
        echo "<==================================================================================================================>"
		echo "<=========================================> WORDPRESS ALLREADY INSTALLED <=========================================>"
		echo "<==================================================================================================================>"
    fi
    exec "$@"
}

main "$@"