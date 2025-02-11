all:
	@if [ -f ./srcs/.env ]; then \
		read -p "Do you want to renew environment variables? (y/n): " choice; \
		if [ "$$choice" = "y" ]; then \
			bash ./srcs/env_builder.sh; \
			mv ./.env ./srcs/.env; \
		fi \
	else \
		bash ./srcs/env_builder.sh; \
		mv ./.env ./srcs/.env; \
	fi
	@mkdir -p ~/data
	@mkdir -p ~/data/mariadb ~/data/wordpress
	@chown -R $(id -u):$(id -g) ~/data/mariadb ~/data/wordpress
	@chmod -R 777 ~/data/mariadb ~/data/wordpress
	@sleep 1
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

erase:
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm
	@rm -rf ~/data
	@rm -rf ~/data/mariadb ~/data/wordpress

re: stop all

mariadb:
	docker exec -it mariadb /bin/bash

wordpress:
	docker exec -it wordpress /bin/bash

nginx:
	docker exec -it nginx /bin/bash

recreate:
	docker compose -f ./srcs/docker-compose.yml up -d --build --force-recreate

.PHONY: stop erase recreate nginx wordpress mariadb re all