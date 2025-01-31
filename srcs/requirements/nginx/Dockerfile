FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y \
		apt install nginx -y \
        apt clean

COPY    ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE  80

CMD     ["nginx", "-g", "daemon off;"]