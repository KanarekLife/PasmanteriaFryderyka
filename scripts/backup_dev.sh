#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

GET_MARIADB_CONTAINER='docker ps --filter "ancestor=mariadb:11.5" --format "{{.ID}}"'
export $(grep -v '^#' ../src/.env | xargs)

ACTION=$1

case $ACTION in
  import)
    if [ $# -eq 2 ]; then
        docker exec -i $(docker ps --filter "ancestor=mariadb:11.5" --format "{{.ID}}") mariadb -u root -p${MARIADB_ROOT_PASSWORD} < $2
    else
        echo "Enter path to database backup"
    fi
    ;;
  create)
	EPOCHSECONDS=$(date +%s)

	FILE="../database-backup/all-db-backup-${EPOCHSECONDS}.sql"

	if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
	    echo "Error: MARIADB_ROOT_PASSWORD is not set."
	    exit 1
	fi

	CONTAINER_ID=$(docker ps --filter "ancestor=mariadb:11.5" --format "{{.ID}}")

	if [ -z "$CONTAINER_ID" ]; then
	    echo "Error: No running container found with the image 'mariadb:11.5'."
	    exit 1
	fi

	docker exec -i $CONTAINER_ID mariadb-dump -u root -p${MARIADB_ROOT_PASSWORD} --all-databases > ${FILE}
	echo "Backup ${FILE} created successfully."
    ;;
  *)
    echo "Invalid action $ACTION - expected create|import [database backup path]"
    ;;
esac
