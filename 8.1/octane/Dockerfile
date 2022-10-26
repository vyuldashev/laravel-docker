FROM php:8.1-cli-alpine

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV CONFIG_CACHE=true \
    ROUTE_CACHE=true \
    VIEW_CACHE=true \
    STORAGE_LINK=false \
    OCTANE_SERVER=swoole

RUN apk update && apk add \
    libzip-dev \
    zip \
    unzip \
    autoconf && \
    apk add --no-cache --virtual \
    .build-deps \
    linux-headers \
    gcc \
    g++ \
    libc-dev \
    make && \
    pecl install -D 'enable-openssl="yes"' openswoole

RUN docker-php-ext-configure zip && \
    docker-php-ext-install pdo_mysql zip bcmath pcntl && \
    docker-php-ext-enable openswoole

RUN apk add --update --no-cache gmp gmp-dev mysql-client && \
    docker-php-ext-install gmp

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/app

COPY . /var/www/app

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0",  "--port=80"]


