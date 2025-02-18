FROM	debian:bullseye

RUN		apt update -y && apt upgrade -y \
		&& apt install nginx openssl -y

RUN		mkdir -p /etc/nginx/ssl \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt \
		-subj "/C=ES/ST=Malaga/L=Malaga/O=42/OU=Mente_galaxia/CN=saroca-f"

COPY	./index.html /var/www/html
COPY	./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE  443

#BONUS PART
COPY	../tools/index.html /usr/share/nginx/static/index.html

CMD     ["nginx", "-g", "daemon off;"]