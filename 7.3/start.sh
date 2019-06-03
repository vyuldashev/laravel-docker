#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-web}
env=${APP_ENV:-production}
link_storage=${LINK_STORAGE:false}

if [[ "$link_storage" ]]; then
        php /var/www/artisan storage:link
fi

if [[ "$role" = "web" ]]; then

    exec /init

elif [[ "$role" = "queue" ]]; then

    worker_queue_name=${WORKER_QUEUE_NAME:-default}
    worker_timeout=${WORKER_TIMEOUT:-60}
    worker_sleep=${WORKER_SLEEP:-3}

    php /var/www/artisan queue:work --queue=${worker_queue_name} --timeout=${worker_timeout} --sleep=${worker_sleep}

elif [[ "$role" = "scheduler" ]]; then

    while [[ true ]]
    do
      php /var/www/artisan schedule:run --verbose --version --no-interaction &
      sleep 60
    done

fi
