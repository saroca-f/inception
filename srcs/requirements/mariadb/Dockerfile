# start from penultimate stable version of debian
FROM debian:bullseye

# apt update and upgrade
RUN apt update -y && apt upgrade -y

# install mariadb
RUN apt install mariadb-server -y

RUN mkdir /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
# mariadb necesita una carpeta temporal para almacenar archivos esenciales miestras esta funcionando.
# por eso creamos una.
# chown significa "Change Owner" o "Cambiar Propietario".
# -R significa que sea recursivo para que incluya todo lo que hay dentro de la carpeta.
# la parte de mysql:mysql responde de la siguiente manera: usuario:grupo.
# indicas que /run/mysqld pertenece al usuario del grupo mysql y al grupo mysql.

# mariadb configuration file
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY:Es una instrucción en Docker que copia archivos o directorios desde tu 
#  máquina host (el sistema donde estás ejecutando docker build) al sistema de
#  archivos del contenedor.

# healthcheck
COPY tools/healthcheck.sh ./healthcheck.sh
RUN chmod +x ./healthcheck.sh

# init script
COPY tools/init.sh ./init.sh
RUN chmod +x ./init.sh

ENTRYPOINT ["sh"]
CMD ["./init.sh"]

#apt es el gestor de paquetes de debian
#en el primer caso "install" de "install mariadb" hace referencia a la accion de apt que estoy solicitando