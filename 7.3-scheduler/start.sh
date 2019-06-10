#!/usr/bin/env bash

set -e
#
sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php/${PHP_VERSION}/cli/php.ini
sed -i "/memory_limit = .*/c\memory_limit = $PHP_MEMORY_LIMIT" /etc/php/${PHP_VERSION}/fpm/php.ini

# OPCache extreme mode.
if [[ $OPCACHE_MODE == "extreme" ]]; then
    # enable extreme caching for OPCache.
    echo "opcache.enable=1" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
    echo "opcache.memory_consumption=512" | tee -a /etc/php/${PHP_VERSION}/mods-available/opcache.ini > /dev/null
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

# run the original command
exec "$@"
