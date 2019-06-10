FROM ubuntu:18.04

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV PHP_VERSION 7.3

ENV OPCACHE_MODE="extreme" \
    PHP_MEMORY_LIMIT=256M

# Add the ENTRYPOINT script
ADD start.sh /scripts/start.sh

RUN apt-get update && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
    vim \
    nano \
    curl \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-memcached \
    php${PHP_VERSION}-apc \
    php${PHP_VERSION}-apcu && \
    php -m && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod +x /scripts/start.sh && \
    mkdir -p /run/php && chmod -R 755 /run/php && \
    mkdir -p /var/www/app && \
    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf && \
    sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf && \
    sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php/${PHP_VERSION}/fpm/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php/${PHP_VERSION}/fpm/php.ini

WORKDIR /var/www/app

ONBUILD ADD . /var/www/app

ENTRYPOINT ["/scripts/start.sh"]


