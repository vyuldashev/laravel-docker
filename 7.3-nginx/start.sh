#!/usr/bin/env bash

set -e

if [[ $STORAGE_LINK == "true" ]]; then
        php /var/www/app/artisan storage:link
fi

# Starts FPM
nohup /usr/sbin/php-fpm${PHP_VERSION} -F -O 2>&1 &

# Starts NGINX!
/usr/sbin/nginx
