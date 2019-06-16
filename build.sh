#!/usr/bin/env bash

docker build 7.3 -t misterio92/laravel:7.3
docker push misterio92/laravel:7.3

docker build 7.3-nginx -t misterio92/laravel:7.3-nginx
docker push misterio92/laravel:7.3-nginx

docker build 7.3-scheduler -t misterio92/laravel:7.3-scheduler
docker push misterio92/laravel:7.3-scheduler
