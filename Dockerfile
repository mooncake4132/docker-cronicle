FROM node:10.10-alpine

WORKDIR /opt/cronicle/

ARG CRONICLE_VERSION=0.8.53

RUN apk add --no-cache --virtual .dep curl tar \
    # Install Cronicle
    && mkdir -p /opt/cronicle \
    && cd /opt/cronicle \
    && curl -L https://github.com/jhuckaby/Cronicle/archive/v${CRONICLE_VERSION}.tar.gz | tar zxvf - --strip-components 1 \
    && npm install \
    && node bin/build.js dist \
    && apk del .dep

COPY entrypoint.sh /entrypoint.sh
COPY setup.json conf/setup.json

EXPOSE 3012

ENV ADMIN_USERNAME="admin" \
    ADMIN_PASSWORD="admin" \
    ADMIN_FULLNAME="Admin" \
    ADMIN_EMAIL="admin@example.com"

VOLUME [ "/opt/cronicle/data", "/opt/cronicle/logs" ]

ENTRYPOINT [ "/entrypoint.sh" ]
