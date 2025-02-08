all:
	@mkdir -p ~/data
	@mkdir -p ~/data/mariadb ~/data/nginx
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d --build
	@echo "Prueba"