#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ../src

ACTION=$1
COMPOSE_FILE=${2:-docker-compose.dev.yaml}

case $ACTION in
  start)
    docker compose -f $COMPOSE_FILE up -d prestashop-dev
    ;;
  run)
    docker compose -f $COMPOSE_FILE up prestashop-dev
    ;;
  stop)
    docker compose -f $COMPOSE_FILE down prestashop-dev
    ;;
  build)
    docker compose -f $COMPOSE_FILE build prestashop-dev
    ;;
  backup)
    docker compose -f $COMPOSE_FILE run -e OPERATION=backup --rm prestashop-db-backup-restore
    ;;
  restore)
    docker compose -f $COMPOSE_FILE run -e OPERATION=restore --rm prestashop-db-backup-restore
    ;;
  *)
    echo "Invalid action $ACTION - expected start|run|stop|build"
    ;;
esac
