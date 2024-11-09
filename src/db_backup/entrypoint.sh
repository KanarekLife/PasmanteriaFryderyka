#!/bin/sh

set -e
if [ "$OPERATION" = "backup" ]; then
  echo "Creating backup..."
  mariadb-dump -P 3306 -h $MARIADB_HOST -u root -p$MARIADB_ROOT_PASSWORD --all-databases > db_backup/backup.sql
elif [ "$OPERATION" = "restore" ]; then
  echo "Restoring backup..."
  mariadb -P 3306 -h $MARIADB_HOST -u root -p$MARIADB_ROOT_PASSWORD < db_backup/backup.sql
else
  echo "Invalid operation $OPERATION - expected backup|restore"
  exit 1
fi