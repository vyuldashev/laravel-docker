#!/usr/bin/env bash

echo "CLI"
docker build 7.3-cli --pull -t misterio92/laravel:7.3-cli

echo "FPM"
docker build 7.3-fpm --pull -t misterio92/laravel:7.3-fpm

echo "Scheduler"
docker build 7.3-scheduler -t misterio92/laravel:7.3-scheduler

echo "Nginx"
docker build nginx --pull -t misterio92/laravel:nginx
