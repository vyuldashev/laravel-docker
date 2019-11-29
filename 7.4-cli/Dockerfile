FROM php:7.4-cli

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV CONFIG_CACHE=true \
    ROUTE_CACHE=true \
    VIEW_CACHE=true \
    STORAGE_LINK=false

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip

RUN docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install pdo_mysql zip bcmath pcntl sockets

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/app

ONBUILD COPY . /var/www/app

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["php", "artisan"]

