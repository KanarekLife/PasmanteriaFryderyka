#!/bin/sh

set -e
if [ "$OPERATION" = "backup" ]; then
  echo "Creating backup..."
  mariadb-dump -P 3306 -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE > ./backup.sql
elif [ "$OPERATION" = "restore" ]; then
  echo "Restoring backup..."
  mariadb -P 3306 -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE < ./backup.sql
else
  echo "Invalid operation $OPERATION - expected backup|restore"
  exit 1
fi