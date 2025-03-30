# Colors for pretty output
GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
YELLOW = \033[0;33m
RESET = \033[0m

# Default target
all: build up logs

# Create necessary directories for persistent data
create_volumes:
	@printf "$(BLUE)Creating data volumes...$(RESET)\n"
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	@printf "$(GREEN)Volumes created successfully!$(RESET)\n"

# Build all Docker images
build: create_volumes
	@printf "$(BLUE)Building Docker images...$(RESET)\n"
	@cd srcs && docker compose build
	@printf "$(GREEN)Build completed successfully!$(RESET)\n"

# Start all containers in detached mode
up:
	@printf "$(BLUE)Starting containers...$(RESET)\n"
	@cd srcs && docker compose up -d
	@printf "$(GREEN)Containers are up and running!$(RESET)\n"

# Stop all containers
down:
	@printf "$(YELLOW)Stopping containers...$(RESET)\n"
	@cd srcs && docker compose down
	@printf "$(GREEN)Containers stopped successfully!$(RESET)\n"

# Complete cleanup including images
fclean: clean
	@printf "$(RED)Removing all Docker images...$(RESET)\n"
	@yes | docker system prune -a
	@printf "$(GREEN)Clean completed successfully!$(RESET)\n"

# Remove containers and volumes
clean: down
	@printf "$(YELLOW)Cleaning up containers and volumes...$(RESET)\n"
	@cd srcs && docker compose rm -v
	@rm -rf ~/data/mariadb
	@rm -rf ~/data/wordpress
	@printf "$(GREEN)Cleanup completed successfully!$(RESET)\n"

# Rebuild everything
re: clean all

# Container shell access
attach-db:
	@printf "$(BLUE)Attaching to MariaDB shell...$(RESET)\n"
	@docker exec -it mariadb /bin/sh

attach-wp:
	@printf "$(BLUE)Attaching to WordPress shell...$(RESET)\n"
	@docker exec -it wordpress /bin/sh

attach-ng:
	@printf "$(BLUE)Attaching to Nginx shell...$(RESET)\n"
	@docker exec -it nginx /bin/sh

# Log viewing commands
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

# Declare all targets as PHONY
.PHONY: all create_volumes build up down fclean clean re \
        attach-db attach-wp attach-ng logs mariadb-logs wordpress-logs nginx-logs

