FROM nginx:1.17-perl

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV FPM_ADDRESS="fpm:9000"

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/app

ONBUILD COPY . /var/www/app

