all: build up 

up:
	cd srcs && docker compose up -d 

build:
	cd srcs && docker compose build 

down:
	cd srcs && docker compose down 

fclean: clean
	yes | docker system prune -a 

attach:
	docker exec -it mariadb /bin/sh

clean: down
	cd srcs && docker compose rm -v 

re: clean build up 

.PHONY: up build down fclean attach clean re

