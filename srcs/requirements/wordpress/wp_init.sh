#!/bin/bash

# Create a variable and asign the "mayor_version.minor_version"
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")

# Create a directory to save PHP files
mkdir -p /run/php
# -p: If the directy exist, not do nothing.

# Configure permisions
chown -R www-data.www-data /var/www/html/wordpress
# Change the owner of WordPress to the webserver user.
chmod -R 755 /var/www/html/wordpress
# Chage permissions so that only the owner can write.
# -R (recoursive): Changue all files and directories in WordPress.

sed -i "s#listen = /run/php/php${PHP_VERSION}-fpm.sock#listen = wordpress:9000#g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
# sed: command that look for a text and substitutes it in files.
# -i: Make sed modify the file instead of creating a new one with the new text.
# listen = /run/php/php${PHP_VERSION}-fpm.sock -> what is looking for.
# listen = wordpress:9000#g = 

cd /usr/local/bin

# Download wp-cli.phar from GitHub
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wp-cli.phar (WordPress Command Line Interface) -> A PHP executable.
# This program contains all the necessary tools to execute commands in WP-CLI.

# Rename the file "wp-cli.phar" to "wp"
mv wp-cli.phar wp

# Allow it to be run as a program.
chmod +x wp

cd /var/www/html/wordpress

# wp: WP-CLI tool.
# Generate the wp-config.php file with database connection details.
# This file stores database credentials and other WordPress settings.
# wp-config.php -> A configuration file that contains the database connection details and other settings for WordPress.
wp config create --allow-root	--dbname=$SQL_DATABASE \
								--dbuser=$SQL_USER \
								--dbpass=$SQL_PASSWORD \
								--dbhost=mariadb:3306 \
								--url=$WP_URL \
								--path='/var/www/html/wordpress'

# Install WordPress with the provided settings.
# This finalizes the installation and sets up the site, admin user, and language.
wp core install --allow-root	--url=$WP_URL \
								--title=$WP_TITLE \
								--admin_user=$WP_ADMIN_USR \
								--admin_password=$WP_ADMIN_PWD \
								--admin_email=$WP_ADMIN_EMAIL \
								--skip-email \
								--locale=es_ES \
								--path='/var/www/html/wordpress'

# Create a new user in WordPress
wp user create $WP_USR $WP_EMAIL	--role=author \
									--user_pass=$WP_PWD \
									--allow-root

wp theme install inspire --allow-root 

# Init the PHP-FPM service in foreground (-F).
php-fpm${PHP_VERSION} -F
