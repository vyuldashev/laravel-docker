FROM misterio92/laravel:7.3

LABEL maintainer="Vladimir Yuldashev <misterio92@gmail.com>"

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.9/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=5ddf8ea26b56d4a7ff6faecdd8966610d5cb9d85

RUN curl -fsSLO "$SUPERCRONIC_URL" \
     && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
     && chmod +x "$SUPERCRONIC" \
     && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
     && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

WORKDIR /var/www/app

ADD crontab /app/crontab

ONBUILD COPY . /var/www/app

ENTRYPOINT ["/scripts/start.sh"]
CMD ["supercronic", "/app/crontab"]
