FROM php:8.4-cli

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV CONFIG_CACHE=true \
    ROUTE_CACHE=true \
    VIEW_CACHE=true \
    STORAGE_LINK=false \
    OCTANE_SERVER=swoole

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    autoconf \
    libssl-dev \
    libgmp10 \
    libgmp-dev \
    default-mysql-client

ADD https://github.com/dunglas/frankenphp/releases/download/v1.0.1/frankenphp-linux-x86_64 /usr/local/bin/frankenphp
RUN chmod +x /usr/local/bin/frankenphp

WORKDIR /var/www/app

COPY . /var/www/app

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0",  "--port=80"]


