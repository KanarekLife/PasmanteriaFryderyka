#!/bin/sh

set -e
if [ "$OPERATION" = "backup" ]; then
  echo "Creating backup..."

  mariadb-dump -P 3306 -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME >/tmp/backup.sql

  # Replace all sensitive data with environment variables
  sed -i -e "s/$MAIL_USER/\$MAIL_USER/g" /tmp/backup.sql
  sed -i -e "s/$MAIL_PASSWORD/\$MAIL_PASSWORD/g" /tmp/backup.sql
  sed -i -e "s/$PRESTASHOP_URL/\$PRESTASHOP_URL/g" /tmp/backup.sql
  sed -i -e "s/$API_KEY/\$API_KEY/g" /tmp/backup.sql

  # Make sure than the encoding is correct
  sed -i -e "s/utf8mb3/utf8mb4/g" /tmp/backup.sql
  sed -i -e "s/utf8mb4_uca1400_ai_ci/utf8mb4_unicode_ci/g" /tmp/backup.sql

  mv /tmp/backup.sql ./backup.sql
elif [ "$OPERATION" = "restore" ]; then
  echo "Restoring backup..."

  # Remove broken first line and move to tmp
  tail -n +2 ./backup.sql > /tmp/backup.sql

  # Replace all environment variables with sensitive data
  sed -i -e "s/\$MAIL_USER/$MAIL_USER/g" /tmp/backup.sql
  sed -i -e "s/\$MAIL_PASSWORD/$MAIL_PASSWORD/g" /tmp/backup.sql
  sed -i -e "s/\$PRESTASHOP_URL/$PRESTASHOP_URL/g" /tmp/backup.sql
  sed -i -e "s/\$API_KEY/$API_KEY/g" /tmp/backup.sql

  mariadb -P 3306 -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME </tmp/backup.sql
  rm /tmp/backup.sql
else
  echo "Invalid operation $OPERATION - expected backup|restore"
  exit 1
fi
