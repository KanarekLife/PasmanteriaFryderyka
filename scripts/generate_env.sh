#!/bin/bash

generate_password() {
    echo $(tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1)
}

generate_api_key() {
    echo $(tr -dc 'A-Z0-9' </dev/urandom | head -c 32)
}

echo "MARIADB_ROOT_PASSWORD=$(generate_password 32)"
echo "MARIADB_DATABASE=prestashop"
echo "MARIADB_USER=prestashop-user"
echo "MARIADB_PASSWORD=$(generate_password 32)"
echo "MARIADB_HOST=prestashop-db"
echo "DOMAIN=${1:-localhost}"
echo "PRESTASHOP_URL=${1:-localhost}:8443"
echo "MAIL_USER=pasmanteriafryderyka@nasus.dev"
echo "MAIL_PASSWORD=$(generate_password 32)"
echo "API_KEY=$(generate_api_key)"
echo "SECRET=$(generate_password 64)"
echo "COOKIE_KEY=$(generate_password 64)"
echo "COOKIE_IV=$(generate_password 32)"

NEW_COOKIE_KEY=def00000$(hexdump -vn32 -e'32/4 "%08X" 1 "\n"' /dev/urandom | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
echo "NEW_COOKIE_KEY=$NEW_COOKIE_KEY$(echo -n $NEW_COOKIE_KEY | xxd -r -p | sha256sum | cut -d' ' -f1)"
