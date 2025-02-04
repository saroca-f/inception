# start from penultimate stable version of debian
FROM debian:bullseye

# apt update and upgrade
RUN apt update -y && apt upgrade -y

# install mariadb
RUN apt install mariadb-server -y

# take my mariadv configuration
COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb_init.sh /

CMD ["bash", "mariadb_init.sh"]