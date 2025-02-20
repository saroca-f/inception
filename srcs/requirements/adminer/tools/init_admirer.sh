#! /bin/bash

VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")

mkdir -p /run/php

mv /etc/php/$VERSION/fpm/pool.d/www.conf /etc/php/$VERSION/fpm/pool.d/test

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/$VERSION/fpm/pool.d/test

mv /etc/php/$VERSION/fpm/pool.d/testo /etc/php/$VERSION/fpm/pool.d/www.conf 

php-fpm$VERSION -F