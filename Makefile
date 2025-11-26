GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
YELLOW = \033[0;33m
RESET = \033[0m


ifeq ($(shell uname),Darwin)
	MARIADB_DIR := $PWD/data/mariadb
	WORDPRESS_DIR := $PWD/data/wordpress
else
	MARIADB_DIR := /home/${USER}/data/mariadb
	WORDPRESS_DIR := /home/${USER}/data/wordpress
endif

export MARIADB_DIR
export WORDPRESS_DIR

all: build up

create_volumes:
	@printf "$(BLUE)Creating data volumes...$(RESET)\n"
	@mkdir -p ${MARIADB_DIR}
	@mkdir -p ${WORDPRESS_DIR}
	@printf "$(GREEN)Volumes created successfully!$(RESET)\n"

build: create_volumes
	@printf "$(BLUE)Building Docker images...$(RESET)\n"
	@cd srcs && docker compose build
	@printf "$(GREEN)Build completed successfully!$(RESET)\n"

up:
	@printf "$(BLUE)Starting containers...$(RESET)\n"
	@cd srcs && docker compose up -d
	@printf "$(GREEN)Containers are up and running!$(RESET)\n"

down:
	@printf "$(YELLOW)Stopping containers...$(RESET)\n"
	@cd srcs && docker compose down
	@printf "$(GREEN)Containers stopped successfully!$(RESET)\n"

ifeq ($(shell uname), Darwin)
fclean:
	@printf "$(RED)Removing all Docker images...$(RESET)\n"
	@cd srcs && docker compose down -v
	@yes | docker system prune -af
	@yes | docker volume prune -f
	@yes | docker network prune -f
	@rm -rf ${MARIADB_DIR}
	@rm -rf ${WORDPRESS_DIR}
	@printf "$(GREEN)Clean completed successfully!$(RESET)\n"
else
fclean:
	@printf "$(RED)Removing all Docker images...$(RESET)\n"
	@cd srcs && docker compose down -v
	@yes | docker system prune -af
	@yes | docker volume prune -f
	@yes | docker network prune -f
	@sudo rm -rf ${MARIADB_DIR}
	@sudo rm -rf ${WORDPRESS_DIR}
	@printf "$(GREEN)Clean completed successfully!$(RESET)\n"
endif 

ifeq ($(shell uname), Darwin)
clean: down
	@printf "$(YELLOW)Cleaning up containers and volumes...$(RESET)\n"
	@rm -rf ${MARIADB_DIR}
	@rm -rf ${WORDPRESS_DIR}
	@printf "$(GREEN)Cleanup completed successfully!$(RESET)\n"
else
clean: down
	@printf "$(YELLOW)Cleaning up containers and volumes...$(RESET)\n"
	@sudo rm -rf ${MARIADB_DIR}
	@sudo rm -rf ${WORDPRESS_DIR}
	@printf "$(GREEN)Cleanup completed successfully!$(RESET)\n"
endif 

re: fclean all

attach-db:
	@printf "$(BLUE)Attaching to MariaDB shell...$(RESET)\n"
	@docker exec -it mariadb /bin/sh

attach-wp:
	@printf "$(BLUE)Attaching to WordPress shell...$(RESET)\n"
	@docker exec -it wordpress /bin/sh

attach-ng:
	@printf "$(BLUE)Attaching to Nginx shell...$(RESET)\n"
	@docker exec -it nginx /bin/sh

logs:
	@printf "$(BLUE)Showing all container logs...$(RESET)\n"
	@cd srcs && docker compose logs -f

mariadb-logs:
	@printf "$(BLUE)Showing MariaDB logs...$(RESET)\n"
	@docker logs -f mariadb

wordpress-logs:
	@printf "$(BLUE)Showing WordPress logs...$(RESET)\n"
	@docker logs -f wordpress

nginx-logs:
	@printf "$(BLUE)Showing Nginx logs...$(RESET)\n"
	@docker logs -f nginx

restart:
	@printf "$(BLUE)Restarting containers...$(RESET)\n"
	@cd srcs && docker compose restart
	@printf "$(GREEN)Containers restarted successfully!$(RESET)\n"

ps:
	@cd srcs && docker compose ps

vol:
	@docker volume ls

vol-wp:
	@docker volume inspect wordpress

vol-db:
	@docker volume inspect mariadb

.PHONY: all create_volumes build up down fclean clean re \
        attach-db attach-wp attach-ng logs mariadb-logs wordpress-logs nginx-logs

