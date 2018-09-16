FROM node:10.10-alpine

WORKDIR /opt/cronicle/

RUN apk add --no-cache --virtual .dep curl \
    # Install Cronicle
    && curl -s "https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js" | node \
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
