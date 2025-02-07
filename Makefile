all:
	@mkdir -p ~/data
	@mkdir -p ~/data/mariadb ~/data/nginx
	@docker compose -f ./srcs/docker-compose.yml up -d --build
	@echo "Prueba"