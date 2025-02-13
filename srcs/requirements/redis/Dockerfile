FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y
RUN		apt install redis -y

COPY	./tools/redis.sh /tmp/redis.sh

EXPOSE  6379

CMD		["sh", "/tmp/redis.sh"]