#!/usr/bin/env bash

echo "CLI"
docker build 7.2-cli --pull -t misterio92/laravel:7.2-cli
docker build 7.3-cli --pull -t misterio92/laravel:7.3-cli
docker build 7.4-cli --pull -t misterio92/laravel:7.4-cli

echo "FPM"
docker build 7.2-fpm --pull -t misterio92/laravel:7.2-fpm
docker build 7.3-fpm --pull -t misterio92/laravel:7.3-fpm
docker build 7.4-fpm --pull -t misterio92/laravel:7.4-fpm

echo "Scheduler"
docker build 7.2-scheduler -t misterio92/laravel:7.2-scheduler
docker build 7.3-scheduler -t misterio92/laravel:7.3-scheduler
docker build 7.4-scheduler -t misterio92/laravel:7.4-scheduler

echo "Nginx"
docker build nginx --pull --no-cache -t misterio92/laravel:nginx
