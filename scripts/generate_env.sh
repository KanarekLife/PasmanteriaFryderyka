#!/bin/bash

generate_password() {
    echo $(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c $1)
}

echo "MARIADB_ROOT_PASSWORD=$(generate_password 32)"
echo "MARIADB_DATABASE=prestashop"
echo "MARIADB_USER=prestashop-user"
echo "MARIADB_PASSWORD=$(generate_password 32)"
echo "MARIADB_HOST=prestashop-db"
echo "DOMAIN=${1:-localhost}"
echo "SECRET=$(generate_password 64)"
echo "COOKIE_KEY=$(generate_password 64)"
echo "COOKIE_IV=$(generate_password 32)"

NEW_COOKIE_KEY=def00000$(hexdump -vn32 -e'32/4 "%08X" 1 "\n"' /dev/urandom | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
echo "NEW_COOKIE_KEY=$NEW_COOKIE_KEY$(echo -n $NEW_COOKIE_KEY | xxd -r -p | sha256sum | cut -d' ' -f1)"