FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache mysql-client

CMD [ "./db_backup/entrypoint.sh" ]