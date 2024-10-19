#!/bin/bash

ACTION=$1
COMPOSE_FILE=${2:-docker-compose.dev.yaml}

case $ACTION in
  start)
    docker compose -f $COMPOSE_FILE up -d
    ;;
  stop)
    docker compose -f $COMPOSE_FILE down
    ;;
  build)
    docker compose -f $COMPOSE_FILE build
    ;;
  *)
    echo "Invalid action $ACTION - expected start|stop|build"
    ;;
esac
