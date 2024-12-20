#!/bin/sh
set -e

envsubst < ./templates/prestashop/app/config/parameters.php > ./prestashop/app/config/parameters.php
envsubst < ./templates/prestashop/config/defines_custom.inc.php > ./prestashop/config/defines_custom.inc.php

if [ "$DEV_MODE" == "true" ]; then
    chmod -R 777 ./prestashop
    echo "Running in development mode"
fi

if [ "$RESTORE_DB" == "true" ]; then
    (
        cd db_backup
        export OPERATION=restore 
        ./db_manager.sh
    )
fi

caddy start
exec php-fpm # without exec, php-fpm will not receive signals
