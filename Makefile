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
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

erase:
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm

re: stop all

mariadb:
	docker exec -it mariadb /bin/bash

wordpress:
	docker exec -it wordpress /bin/bash

nginx:
	docker exec -it nginx /bin/bash

clean:
	docker volume rm mariadb wordpress

recreate:
	docker-compose -f ./srcs/docker-compose.yml up -d --build --force-recreate

.PHONY: stop clean re all