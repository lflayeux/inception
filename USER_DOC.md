# 📖 User Documentation - Inception

*This document explains how to use and manage the Inception services stack.*

## 1. Services Overview
This project runs the following services defined in `srcs/docker_compose.yaml`:
- **Nginx:** Serves the main WordPress site over HTTPS and routes requests to the WordPress and bonus static site containers.
- **MariaDB:** Provides the database backend for WordPress and stores all site data.
- **WordPress:** Hosts the website and its administration interface.
- **Redis:** A caching service used by the stack to improve performance.
- **FTP:** Provides FTP access to the WordPress files and is used for file transfer operations.
- **Adminer:** A web-based database management tool for MariaDB.
- **Static Site:** A bonus static website served by the same domain under `/static`.
- **Fail2ban:** Protects the FTP service by monitoring login attempts and banning suspicious clients.

## 2. Managing the Project
From the project root, use these commands to manage the stack:
- **Start the project:** `make`
- **Stop the project:** `make stop` (stops containers but keeps persistent data)
- **Clean up:** `make fclean` (stops containers, removes containers and volumes, and prunes Docker resources)

## 3. Accessing the Platform
The services are accessible via the following URLs (ensure `lflayeux.42.fr` is in your hosts file):
- **Main Website (WordPress):** https://lflayeux.42.fr
- **Database Management (Adminer):** https://lflayeux.42.fr/adminer
- **Bonus Static Site:** https://lflayeux.42.fr/static

## 4. Credentials Management
Credentials and secrets are managed in the project configuration files:
- The environment variables are loaded from `srcs/.env`.
- Docker secrets are stored under `srcs/conf/secrets/` for sensitive values like `db_root`, `db_user`, `wp_admin`, and `wp_user`.

These files contain sensitive information and should not be committed to Git. Keep them private and outside version control for security.

## 5. Health Status
To verify that all services are running correctly:
- Run `docker ps` to check the status.
- All mandatory services (Nginx, WordPress, MariaDB) should show as `(healthy)`.