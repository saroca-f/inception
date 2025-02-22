#!/bin/bash

PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")

mkdir -p /run/php

chown -R www-data.www-data /var/www/html/wordpress

chmod -R 755 /var/www/html/wordpress

sed -i "s#listen = /run/php/php${PHP_VERSION}-fpm.sock#listen = wordpress:9000#g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

cd /usr/local/bin

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

mv wp-cli.phar wp

chmod +x wp

cd /var/www/html/wordpress

wp config create --allow-root	--dbname=$SQL_DATABASE \
								--dbuser=$SQL_USER \
								--dbpass=$SQL_PASSWORD \
								--dbhost=mariadb:3306 \
								--url=$WP_URL \
								--path='/var/www/html/wordpress'

wp core install --allow-root	--url=$WP_URL \
								--title=$WP_TITLE \
								--admin_user=$WP_ADMIN_USR \
								--admin_password=$WP_ADMIN_PWD \
								--admin_email=$WP_ADMIN_EMAIL \
								--skip-email \
								--locale=es_ES \
								--path='/var/www/html/wordpress'

wp user create $WP_USR $WP_EMAIL	--role=author \
									--user_pass=$WP_PWD \
									--allow-root

wp config set WP_REDIS_HOST 'redis' --allow-root 
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_CACHE true --raw --allow-root
wp config set WP_CACHE_KEY_SALT 'mywordpresssite_' --allow-root
wp config set WP_REDIS_CLIENT 'phpredis' --allow-root

wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root

wp theme install inspire --allow-root 

php-fpm${PHP_VERSION} -F