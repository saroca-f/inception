all:
	@mkdir -p ~/data
	@mkdir -p ~/datamariadb ~/data/nginx
	@docker compose -f ./srcs/docker-compose.yml up -d --build
	@echo "Prueba"