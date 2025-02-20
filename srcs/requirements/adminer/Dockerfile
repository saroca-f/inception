FROM debian:bullseye

RUN apt update -y && apt install -y

RUN apt install -y php php-cli php-mbstring php-mysql php-fpm wget

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php" -O index.php

RUN mkdir -p /var/www/html && mv index.php /var/www/html/

COPY ./tools/init_admirer.sh /tmp

CMD ["bash", "tmp/init_admirer.sh"]