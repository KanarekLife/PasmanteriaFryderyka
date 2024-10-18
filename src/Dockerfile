FROM php:7.4-fpm-alpine

WORKDIR /app

RUN apk add --no-cache \
    caddy \
    nss-tools \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    jpeg-dev \
    icu-dev

RUN docker-php-ext-configure gd --with-jpeg

RUN docker-php-ext-install \
    zip \
    gd \
    pdo_mysql\
    intl \
    opcache

RUN echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

EXPOSE 80 443

COPY entrypoint.sh Caddyfile ./

COPY prestashop /app/prestashop

CMD [ "./entrypoint.sh" ]