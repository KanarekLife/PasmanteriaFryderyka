#!/bin/sh
set -e

envsubst < ./templates/prestashop/app/config/parameters.php > ./prestashop/app/config/parameters.php
if [ "$DEV_MODE" == "true" ]; then
    chmod -R 777 ./prestashop
    echo "Running in development mode"
else
    chown -R www-data:www-data ./prestashop
    chmod -R 755 ./prestashop
fi
envsubst < ./templates/prestashop/config/defines_custom.inc.php > ./prestashop/config/defines_custom.inc.php


caddy start
exec php-fpm # without exec, php-fpm will not receive signals