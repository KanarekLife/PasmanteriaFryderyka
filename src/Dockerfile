FROM php:7.4-fpm-alpine AS prestashop-base
WORKDIR /app
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

RUN apk add --no-cache \
    gettext \
    caddy \
    nss-tools \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    jpeg-dev \
    icu-dev \
    mariadb-client \
    mariadb-connector-c \
    memcached \
    libmemcached-dev \
    libmemcached \
    zlib-dev
RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install \
    zip \
    gd \
    pdo_mysql\
    intl \
    opcache
# Install memcached PHP extension
RUN apk add --no-cache make g++ autoconf pkgconfig && pecl install memcached && \
    docker-php-ext-enable memcached && apk del make g++ autoconf pkgconfig
# Set location for Caddy configuration and data
COPY Caddyfile entrypoint.sh /app/
COPY templates /app/templates
EXPOSE 80 443
ENTRYPOINT [ "./entrypoint.sh" ]

FROM prestashop-base AS prestashop-dev
RUN echo 'php_admin_flag[display_errors] = on' >> /usr/local/etc/php/conf.d/docker-php-logs.ini;

FROM prestashop-base AS prestashop
COPY --chown=www-data:www-data --chmod=755 prestashop /app/prestashop
COPY db_backup /app/db_backup
