#!/bin/sh
set -e

envsubst < ./templates/prestashop/app/config/parameters.php > ./prestashop/app/config/parameters.php
chmod 777 ./prestashop/app/config/parameters.php
envsubst < ./templates/prestashop/config/defines_custom.inc.php > ./prestashop/config/defines_custom.inc.php


caddy start
exec php-fpm # without exec, php-fpm will not receive signals