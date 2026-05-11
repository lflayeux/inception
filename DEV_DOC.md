# 🛠️ Developer Documentation - Inception

*Technical guide for setting up and maintaining the Inception Docker infrastructure.*

## 1. Environment Setup
### Prerequisites
- OS: Linux (Debian/Ubuntu recommended)
- Tools: Docker, Docker Compose, GNU Make.

### Configuration Files
The main project configuration lives under `srcs/`.
- `srcs/docker_compose.yaml` defines the full stack and service dependencies.
- `srcs/conf/env/.env` contains the environment variables used by MariaDB, WordPress, and Nginx.
- `srcs/conf/secrets/` holds Docker secrets for sensitive values such as `db_root`, `db_user`, `wp_admin`, and `wp_user`.

If any secret files are missing, create them manually with the expected secret values. These secret files are not part of the repository and must be kept private.

## 2. Build & Launch Process
The project uses a **multi-container Docker architecture**.
- **Building and launching:** run `make` from the repository root.
- `make` creates required host directories under `/home/lflayeux/data/` and then starts the stack with:
  `docker compose -f srcs/docker_compose.yaml --env-file srcs/conf/env/.env -p inception up -d --build`
- The build uses Dockerfiles in the project:
  - `srcs/mariadb/`
  - `srcs/wordpress/`
  - `srcs/nginx/`
  - `srcs/bonus/redis/`
  - `srcs/bonus/adminer/`
  - `srcs/bonus/static-site/`
  - `srcs/bonus/ftp/`
  - `srcs/bonus/fail2ban/`
- **Orchestration:** Docker Compose manages service start order and health checks.
  - `wordpress` waits for `mariadb` to become healthy.
  - `nginx` waits for `wordpress` and the bonus services to start.
  - `fail2ban` waits for `ftp` to start.

## 3. Essential Dev Commands
Use these commands during development and troubleshooting:
- `docker compose -f srcs/docker_compose.yaml --env-file srcs/conf/env/.env -p inception ps` — list stack containers.
- `docker logs <container>` — view logs for a container, e.g. `docker logs wordpress`.
- `docker exec -it <container> sh` — open a shell inside a running container.
- `docker volume ls` — list Docker volumes.
- `docker compose -p inception down --rmi all -v` — stop the stack and remove containers, images, and volumes.
- `make stop` — stop the stack without removing volumes.
- `make fclean` — stop the stack and remove containers, images, and host data under `/home/lflayeux/data/`.

## 4. Data Persistence & Storage
Persistent data is stored on the host to survive container recreation.
- **Volumes Path:** `/home/lflayeux/data/`
- **Mapped Folders:**
  - `/home/lflayeux/data/db` → MariaDB data volume.
  - `/home/lflayeux/data/wp` → WordPress files volume.
  - `/home/lflayeux/data/static` → static site files volume.
  - `/home/lflayeux/data/logs` → FTP and Fail2ban log volume.

These host-mounted volumes are defined in `srcs/docker_compose.yaml` and ensure data persists across rebuilds.

## 5. Network Architecture
- **Network Name:** `inception-network`
- **Driver:** `bridge`
- **Isolation:** Most service communication is internal to the Docker network.
- **Public access:** Nginx exposes port `443` to the host for HTTPS traffic.
- **FTP access:** The `ftp` container also exposes host ports `21` and `60000-60005` for FTP connections.
- `adminer` and `static-site` are internal services exposed through Nginx or internal routing and are not directly bound to public host ports.