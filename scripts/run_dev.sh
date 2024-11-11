#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ../src

ACTION=$1
COMPOSE_FILE=${2:-docker-compose.dev.yaml}

case $ACTION in
  up)
    docker compose -f $COMPOSE_FILE up -d prestashop-dev
    echo "Prestashop URL: https://localhost:8443"
    echo "Admin URL: https://localhost:8443/$(ls prestashop | grep admin)"
    ;;
  down)
    docker compose -f $COMPOSE_FILE down
    ;;
  build)
    docker compose -f $COMPOSE_FILE build
    ;;
  backup)
    docker compose -f $COMPOSE_FILE run -e OPERATION=backup --rm prestashop-db-backup-restore
    ;;
  restore)
    docker compose -f $COMPOSE_FILE run -e OPERATION=restore --rm prestashop-db-backup-restore
    ;;
  *)
    echo "Invalid action $ACTION - expected up|down|build|backup|restore"
    ;;
esac
