FROM misterio92/laravel:7.3

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

COPY start.sh /home/start.sh

RUN apt-get update && \
    apt-get install -y \
    nginx && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/tmp/nginx && \
    mkdir /var/run/nginx && \
    chmod +x /home/start.sh

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/app

ONBUILD COPY . /var/www/app

EXPOSE 80

CMD ["/home/start.sh"]

