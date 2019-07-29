#!/usr/bin/env bash

set -e

. /scripts/start.sh

# Starts FPM
nohup /usr/sbin/php-fpm${PHP_VERSION} -F -O 2>&1 &

# Starts NGINX!
/usr/sbin/nginx
