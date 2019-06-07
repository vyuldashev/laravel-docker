#!/usr/bin/env bash

set -e

env=${APP_ENV:-production}
link_storage=${LINK_STORAGE:false}

if [[ "$link_storage" ]]; then
        php /var/www/artisan storage:link
fi

exec /init
