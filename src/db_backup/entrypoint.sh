#!/bin/sh

set -e
if [ "$OPERATION" = "backup" ]; then
  echo "Creating backup..."

  mariadb-dump -P 3306 -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE >/tmp/backup.sql

  # Replace all sensitive data with environment variables
  sed -i -e "s/$MAIL_USER/\$MAIL_USER/g" /tmp/backup.sql
  sed -i -e "s/$MAIL_PASSWORD/\$MAIL_PASSWORD/g" /tmp/backup.sql
  sed -i -e "s/$PRESTASHOP_URL/\$PRESTASHOP_URL/g" /tmp/backup.sql

  cp /tmp/backup.sql ./backup.sql
elif [ "$OPERATION" = "restore" ]; then
  echo "Restoring backup..."

  cp ./backup.sql /tmp/backup.sql

  # Replace all environment variables with sensitive data
  sed -i -e "s/\$MAIL_USER/$MAIL_USER/g" /tmp/backup.sql
  sed -i -e "s/\$MAIL_PASSWORD/$MAIL_PASSWORD/g" /tmp/backup.sql
  sed -i -e "s/\$PRESTASHOP_URL/$PRESTASHOP_URL/g" /tmp/backup.sql

  mariadb -P 3306 -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE </tmp/backup.sql
else
  echo "Invalid operation $OPERATION - expected backup|restore"
  exit 1
fi
