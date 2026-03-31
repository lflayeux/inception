GREEN = \033[0;32m
RED   = \033[0;31m
BLUE  = \033[0;34m
END   = \033[0m
ENV_PATH = ./srcs/conf/env/.env
COMPOSE_PATH = ./srcs/docker_compose.yaml
PROJECT_NAME = inception

all:
	@echo "$(GREEN)========================== Building Inception... ==========================$(END)"
	mkdir -p /home/lflayeux/data/wp \
	         /home/lflayeux/data/db \
	         /home/lflayeux/data/static \
	         /home/lflayeux/data/logs
	docker compose -f $(COMPOSE_PATH) --env-file $(ENV_PATH) -p $(PROJECT_NAME) up -d --build
	@echo "$(GREEN)========================== Inception Build... ==========================$(END)"

# logs:
# 	@echo "$(BLUE)============================================================="
# 	@echo "======================== LOGS WP ============================"
# 	@echo "=============================================================$(END)\n"
# 	@docker logs wordpress || echo "$(RED)Conteneur WP introuvable$(END)"
# 	@echo "$(BLUE)============================================================="
# 	@echo "======================== LOGS DB ============================"
# 	@echo "=============================================================$(END)\n"
# 	@docker logs mariadb || echo "$(RED)Conteneur DB introuvable$(END)"
# 	@echo "$(BLUE)================================================================"
# 	@echo "======================== LOGS NGINX ============================"
# 	@echo "================================================================$(END)\n"
# 	@docker logs nginx || echo "$(RED)Conteneur NGINX introuvable$(END)"

# bash-db:
# 	@docker exec -it mariadb sh
# bash-wp:
# 	@docker exec -it wordpress sh

# bash-nginx:
# 	@docker exec -it nginx sh

status:
	docker ps -a

restart:
	sudo cp -rf ./srcs/bonus/static-site/srcs/* /home/lflayeux/data/static/
	docker compose -f $(COMPOSE_PATH) --env-file $(ENV_PATH) -p $(PROJECT_NAME) up -d

start :
	@echo "$(GREEN)========================== Starting Inception... ==========================$(END)"
	docker compose -p $(PROJECT_NAME) start
	@echo "$(GREEN)========================== Inception Started... ==========================$(END)"

stop:
	@echo "$(RED)========================== Stopping Inception... ==========================$(END)"
	docker compose -p $(PROJECT_NAME) stop
	@echo "$(RED)========================== Inception Stopped... ==========================$(END)"


fclean: stop
	@echo "$(RED)========================== Cleaning Inception... ==========================$(END)"
	docker compose -p $(PROJECT_NAME) down --rmi all -v
	sudo rm -rf /home/lflayeux/data/*
	docker system prune -f
	@echo "$(RED)========================== Inception Cleaned... ==========================$(END)"

re: fclean all

# .PHONY all restart start stop fclean re status

