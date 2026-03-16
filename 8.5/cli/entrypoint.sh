#!/bin/sh

set -e

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
