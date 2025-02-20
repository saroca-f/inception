#! /bin/bash

VERSION=$(php -r "echo PHP_VESION_MAYOR . '.' . PHP_VERSION_MINOR;")

cd /etc/php/$VERSION/fpm/pool.d

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/$VERSION/fpm/pool.d/www.conf