USER := $(shell whoami)

all: build up logs

up:
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress
	cd srcs && docker compose up -d 

build:
	cd srcs && docker compose build 

down:
	cd srcs && docker compose down 

fclean: clean
	yes | docker system prune -a 

attach-db:
	docker exec -it mariadb /bin/sh

attach-wp:
	docker exec -it wordpress /bin/sh

attach-ng:
	docker exec -it nginx /bin/sh

clean: down
	cd srcs && docker compose rm -v 
	- rm -rf /home/${USER}/data/mariadb
	- rm -rf /home/${USER}/data/wordpress

re: clean build up 

logs:
	cd srcs && docker compose logs -f

mariadb-logs:
	docker logs -f mariadb

wordpress-logs:
	docker logs -f wordpress

nginx-logs:
	docker logs -f nginx

.PHONY: up build down fclean attach-mariadb attach-wordpress attach-nginx clean re logs mariadb-logs wordpress-logs nginx-logs

