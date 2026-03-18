GREEN = \033[0;32m
RED   = \033[0;31m
BLUE  = \033[0;34m
END   = \033[0m
ENV_PATH = ./docker/conf/env/.env
COMPOSE_PATH = ./docker/docker_compose.yaml
PROJECT_NAME = inception

all:
	docker compose -f $(COMPOSE_PATH) --env-file $(ENV_PATH) -p $(PROJECT_NAME) up -d --build

logs:
	@echo "$(BLUE)============================================================="
	@echo "======================== LOGS WP ============================"
	@echo "=============================================================$(END)\n"
	@docker logs wordpress || echo "$(RED)Conteneur WP introuvable$(END)"
	@echo "$(BLUE)============================================================="
	@echo "======================== LOGS DB ============================"
	@echo "=============================================================$(END)\n"
	@docker logs mariadb || echo "$(RED)Conteneur DB introuvable$(END)"
	@echo "$(BLUE)================================================================"
	@echo "======================== LOGS NGINX ============================"
	@echo "================================================================$(END)\n"
	@docker logs nginx || echo "$(RED)Conteneur NGINX introuvable$(END)"

bash-db:
	@docker exec -it mariadb sh
bash-wp:
	@docker exec -it wordpress sh

bash-nginx:
	@docker exec -it nginx sh

restart:
	docker compose -p $(PROJECT_NAME) restart


start :
	docker compose -p $(PROJECT_NAME) start

stop:
	docker compose -p $(PROJECT_NAME) stop

fclean: stop
	docker compose -p $(PROJECT_NAME) down --rmi all -v
	docker run --rm -v /home/lflayeux/data:/data alpine sh -c "rm -rf /data/db/* /data/wp/*"

re: fclean all

# .PHONY 

