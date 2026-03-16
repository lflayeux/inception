
all:
	docker compose -f ./docker/docker_compose.yaml -p inception up -d --build

logs:
	@echo "======================== LOGS WP ============================\n"
	@docker logs inception-wordpress-1 || echo "Conteneur WP introuvable"
	@echo "\n======================== LOGS DB ============================\n"
	@docker logs inception-mariadb-1 || echo "Conteneur DB introuvable"
	@echo "\n======================== LOGS NGINX ============================\n"
	@docker logs inception-nginx-1 || echo "Conteneur NGINX introuvable"

bash-db:
	@docker exec -it inception-mariadb-1 sh
bash-wp:
	@docker exec -it inception-wordpress-1 sh

bash-nginx:
	@docker exec -it inception-nginx-1 sh

restart:
	docker compose -p inception restart


start :
	docker compose -p inception start

stop:
	docker compose -p inception stop

fclean: stop
	docker compose -p inception down --rmi all -v

re: fclean all

# .PHONY 

