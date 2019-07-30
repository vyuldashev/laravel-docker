FROM nginx:1.17

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/app

ONBUILD COPY . /var/www/app

