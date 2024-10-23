#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ../src

ACTION=$1
COMPOSE_FILE=${2:-docker-compose.dev.yaml}

case $ACTION in
  start)
    docker compose -f $COMPOSE_FILE up -d
    ;;
  run)
    docker compose -f $COMPOSE_FILE up
    ;;
  stop)
    docker compose -f $COMPOSE_FILE down
    ;;
  build)
    docker compose -f $COMPOSE_FILE build
    ;;
  *)
    echo "Invalid action $ACTION - expected start|run|stop|build"
    ;;
esac
