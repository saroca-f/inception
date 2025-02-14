FROM debian:bullseye

RUN apt update -y && apt upgrade -y

# Install ussefull tools -> we will use them later. 
RUN apt install -y wget tar
# wget: To dowload files from the internet.
# tar: To compress or uncompress files.

# Install PHP
RUN apt install -y php-fpm php-mysql
# php-fmp (FastCGI Process Manager): It is used to manage multiple request more efficiently.
# php-mysql: An extension that allows PHP connec to MySQL/MariaDB datebases.

RUN apt install php-redis -y

# Create web director
RUN mkdir -p /var/www/html
# -p: That create all parent directories if they do not exist.

# Dowload Wordpress
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
# -O (output) /tmp/wordpress.tar.gz: Where we will save the file.
# https://wordpress.org/latest.tar.gz: What we will dowload.

# Uncompress Wordpress
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/html && rm /tmp/wordpress.tar.gz
# -x: Indicated to tar you want to extract (uncompress). If you do not use it,  tar assume you want to create an archive.
# -z: Indicated that the file is compressed with gzip.
# -f: Is a required flag that specifies the file to be extracted. -> /tmp/wordpress.tar.gz is the file in this case.
# -C: Indicated where you want the file will be extracted. If you do not use it, tar extracts to the current directory. -> /var/www/html is the direction in this case.

# Install the client of MariaDB
RUN apt install -y mariadb-client
# It is important for comunnicating with the MariaDB Docker container.

COPY ./wp_init.sh /

EXPOSE 9000

# To execute the script
CMD [ "sh", "/wp_init.sh" ]