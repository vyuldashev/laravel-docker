#!/bin/sh

set -e

#case $OCTANE_SERVER in
#
#    roadrunner)
#        ./vendor/bin/rr get-binary
#    ;;
#
#    swoole)
#        apk add --no-cache --virtual .build-deps linux-headers gcc g++ libc-dev make && \
#        pecl install swoole && \
#        docker-php-ext-enable swoole
#    ;;
#
#    *)
#    echo -n "unknown octane runtime"
#    ;;
#
#esac

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

. /usr/local/bin/docker-php-entrypoint

exec "$@"
