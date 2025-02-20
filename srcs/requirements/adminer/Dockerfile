FROM debian:bullseye

RUN apt update -y && apt install -y

RUN mkdir -p /var/www/html

RUN apt install -y php php-cli php-mbstring php-mysql php-fpm wget

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php" -O index.php

RUN mv index.php /var/www/html/

COPY ./tools/init_admirer.sh /tmp

CMD ["/bin/bash", "/tmp/init_admirer.sh"]