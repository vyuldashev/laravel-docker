FROM misterio92/laravel:7.3

# Add wait-for-it
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /bin/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh

# Add S6 supervisor (for graceful stop)
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN apt-get update && \
    apt-get update && \
    apt-get install -y \
    nginx \
    php${PHP_VERSION}-fpm \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && chmod -R 755 /run/php

# Copy NGINX service script
COPY nginx.conf /etc/nginx/nginx.conf
COPY start-nginx.sh /etc/services.d/nginx/run
RUN chmod 755 /etc/services.d/nginx/run

# Copy PHP-FPM service script
COPY php/fpm/php.ini /etc/php/${PHP_VERSION}/fpm/php.ini
COPY php/fpm/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY php/fpm/pool.d/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY start-fpm.sh /etc/services.d/php_fpm/run
RUN chmod 755 /etc/services.d/php_fpm/run

# Copy entrypoint script
COPY start.sh /usr/local/bin/start
RUN chmod 755 /usr/local/bin/start

EXPOSE 80

CMD ["/usr/local/bin/start"]

