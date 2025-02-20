#! /bin/bash

VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")

mkdir /prueba

chmod 777 /etc/php/$VERSION/fpm/pool.d/www.conf

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/$VERSION/fpm/pool.d/www.conf

php-fpm$VERSION -F