#!/usr/bin/env bash

docker build 7.3 --pull -t misterio92/laravel:7.3
docker push misterio92/laravel:7.3

docker build 7.3-nginx --pull -t misterio92/laravel:7.3-nginx
docker push misterio92/laravel:7.3-nginx

docker build 7.3-scheduler --pull -t misterio92/laravel:7.3-scheduler
docker push misterio92/laravel:7.3-scheduler
