FROM redis:5

ENV REDIS_HOST=redis

COPY redis.conf /usr/local/etc/redis/redis.conf
EXPOSE 8080
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
