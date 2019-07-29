#!/usr/bin/env bash

set -e

CPU=$(grep -c ^processor /proc/cpuinfo);
TOTALMEM=$(free -m | awk '/^Mem:/{print $2}');

if [[ "$CPU" -le "2" ]]; then TOTALCPU=2; else TOTALCPU="${CPU}"; fi

# PHP-FPM settings
if [[ -z $PHP_START_SERVERS ]]; then PHP_START_SERVERS=$(($TOTALCPU / 2)); fi
if [[ -z $PHP_MIN_SPARE_SERVERS ]]; then PHP_MIN_SPARE_SERVERS=$(($TOTALCPU / 2)); fi
if [[ -z $PHP_MAX_SPARE_SERVERS ]]; then PHP_MAX_SPARE_SERVERS="${TOTALCPU}"; fi
if [[ -z $PHP_MEMORY_LIMIT ]]; then PHP_MEMORY_LIMIT=$(($TOTALMEM / 2)); fi
if [[ -z $PHP_MAX_CHILDREN ]]; then PHP_MAX_CHILDREN=$(($TOTALCPU * 2)); fi

# Opcache settings
if [[ -z $PHP_OPCACHE_MEMORY_CONSUMPTION ]]; then PHP_OPCACHE_MEMORY_CONSUMPTION=$(($TOTALMEM / 6)); fi

sed -i "/listen = .*/c\listen = 0.0.0.0:9000" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/pm = dynamic/c\pm = static" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/pm.max_children =.*/c\pm.max_children = ${PHP_MAX_CHILDREN}" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/;pm.max_requests =.*/c\pm.max_requests = 1000" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/pm.start_servers =.*/c\pm.start_servers = ${PHP_START_SERVERS}" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/pm.min_spare_servers =.*/c\pm.min_spare_servers = ${PHP_MIN_SPARE_SERVERS}" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/pm.max_spare_servers =.*/c\pm.max_spare_servers = ${PHP_MAX_SPARE_SERVERS}" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/;clear_env = .*/c\clear_env = no" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
sed -i "/post_max_size = .*/c\post_max_size = 1000M" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1000M" /etc/php/${PHP_VERSION}/fpm/php.ini

sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php/${PHP_VERSION}/cli/php.ini
sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php/${PHP_VERSION}/fpm/php.ini

# OPCache extreme mode.
if [[ $OPCACHE_MODE == "extreme" ]]; then
    # enable extreme caching for OPCache.
    echo "opcache.enable=1" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.memory_consumption=$PHP_OPCACHE_MEMORY_CONSUMPTION" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.interned_strings_buffer=128" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.max_accelerated_files=32531" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.validate_timestamps=0" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.save_comments=1" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.fast_shutdown=0" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
fi

if [[ $OPCACHE_MODE == "disabled" ]]; then
    # disable extension.
    sed -i "/zend_extension=opcache/c\;zend_extension=opcache" /etc/php/${PHP_VERSION}/mods-available/opcache.ini
    # set enabled as zero, case extension still gets loaded (by other extension).
    echo "opcache.enable=0" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
fi

# Laravel Optimization

if [[ $CONFIG_CACHE == true ]]; then
    php /var/www/app/artisan config:cache
fi

if [[ $ROUTE_CACHE == true ]]; then
    php /var/www/app/artisan route:cache
fi

if [[ $VIEW_CACHE == true ]]; then
    php /var/www/app/artisan view:cache
fi

if [[ $STORAGE_LINK == true ]]; then
    php /var/www/app/artisan storage:link
fi

# run the original command
exec "$@"
