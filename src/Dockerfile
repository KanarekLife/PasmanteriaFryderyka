FROM php:7.4-fpm-alpine AS prestashop-base

WORKDIR /app

RUN apk add --no-cache \
    gettext \
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
# Set location for Caddy configuration and data
ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data

EXPOSE 80 443

COPY Caddyfile entrypoint.sh /app/

COPY templates /app/templates

CMD [ "./entrypoint.sh" ]



FROM prestashop-base AS prestashop

COPY --chown=www-data:www-data --chmod=755 prestashop /app/prestashop



FROM prestashop-base AS prestashop-dev

RUN echo 'php_admin_flag[display_errors] = on' >> /usr/local/etc/php/conf.d/docker-php-logs.ini;