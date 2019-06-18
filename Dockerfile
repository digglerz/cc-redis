FROM redis:5

ENV NODE_VERSION 8.14.0
ENV ARCH x64
WORKDIR /tmp
RUN apt update -y
RUN buildDeps='xz-utils' \
    && apt install -y ca-certificates curl wget gnupg dirmngr $buildDeps --no-install-recommends \
    && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
    && apt-get purge -y --auto-remove $buildDeps \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN /usr/local/bin/npm install -g http-server

ENV REDIS_HOST=redis

EXPOSE 8080
CMD [ "nohup /usr/local/bin/http-server && redis-server" ]
