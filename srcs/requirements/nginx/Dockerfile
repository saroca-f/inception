FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y \
		&& apt install nginx openssl -y


COPY    ./test.html /var/www/html
COPY    ./conf/default  /etc/nginx/sites-enabled/default
COPY    ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE  80

#CMD     ["nginx", "-g", "daemon off;"]