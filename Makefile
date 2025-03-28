all: build up 

up:
	docker compose up -d

build:
	docker compose build

down:
	docker compose down

fclean: down
	docker compose rm -v

attach:
	docker compose exec mariadb /bin/sh

.PHONY: up build down fclean

