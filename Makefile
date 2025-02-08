all:
	@mkdir -p ~/data
	@mkdir -p ~/data/mariadb ~/data/nginx
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d --build
	@echo "Prueba"

down:
	docker compose -f ./srcs/docker-compose.yml down

re: stop all

mariadb:
	docker exec -it mariadb /bin/bash

wordpress:
	docker exec -it wordpress /bin/bash

nginx:
	docker exec -it nginx /bin/bash

# Remove all volumes
clean:
	docker volume rm mariadb wordpress

# Rebuild images and volumes
recreate:
	docker compose -f ./srcs/docker-compose.yml up -d --build --force-recreate

.PHONY: stop clean re all