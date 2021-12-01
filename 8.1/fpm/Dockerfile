FROM php:8.1-fpm-alpine

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="20000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

ENV CONFIG_CACHE=true \
    ROUTE_CACHE=true \
    VIEW_CACHE=true \
    STORAGE_LINK=false

RUN apk update && apk add \
    libzip-dev \
    zip \
    unzip

RUN docker-php-ext-configure zip && \
    docker-php-ext-install opcache pdo_mysql zip bcmath pcntl sockets

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY opcache.ini $PHP_INI_DIR/conf.d/
COPY entrypoint.sh /scripts/entrypoint.sh

RUN chmod +x /scripts/entrypoint.sh

WORKDIR /var/www/app

ONBUILD COPY . /var/www/app

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["php-fpm"]