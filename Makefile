GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
YELLOW = \033[0;33m
RESET = \033[0m

ifeq ($(shell uname),Darwin)
	MARIADB_DIR := /Users/${USER}/goinfre/data/mariadb
	WORDPRESS_DIR := /Users/${USER}/goinfre/data/wordpress
	SSL_DIR := /Users/${USER}/goinfre/data/ssl
else
	MARIADB_DIR := /home/${USER}/data/mariadb
	WORDPRESS_DIR := /home/${USER}/data/wordpress
	SSL_DIR := /home/${USER}/data/ssl
endif

export MARIADB_DIR
export WORDPRESS_DIR
export SSL_DIR

all: build up logs

create_volumes:
	@printf "$(BLUE)Creating data volumes...$(RESET)\n"
	@mkdir -p ${MARIADB_DIR}
	@mkdir -p ${WORDPRESS_DIR}
	@mkdir -p ${SSL_DIR}
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

fclean: clean
	@printf "$(RED)Removing all Docker images...$(RESET)\n"
	@yes | docker system prune -a
	@printf "$(GREEN)Clean completed successfully!$(RESET)\n"

ifeq ($(shell uname), Darwin)
clean: down
	@printf "$(YELLOW)Cleaning up containers and volumes...$(RESET)\n"
	@rm -rf ${MARIADB_DIR}
	@rm -rf ${WORDPRESS_DIR}
	@rm -rf ${SSL_DIR}
	@printf "$(GREEN)Cleanup completed successfully!$(RESET)\n"
else
clean: down
	@printf "$(YELLOW)Cleaning up containers and volumes...$(RESET)\n"
	@sudo rm -rf ${MARIADB_DIR}
	@sudo rm -rf ${WORDPRESS_DIR}
	@sudo rm -rf ${SSL_DIR}
	@printf "$(GREEN)Cleanup completed successfully!$(RESET)\n"
endif 

re: clean all

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

.PHONY: all create_volumes build up down fclean clean re \
        attach-db attach-wp attach-ng logs mariadb-logs wordpress-logs nginx-logs

