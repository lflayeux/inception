USER_DOC.md — User documentation This file must explain, in clear and simple
terms, how an end user or administrator can:
◦ Understand what services are provided by the stack. [list of all the services]
◦ Start and stop the project. []
◦ Access the website and the administration panel. [lien vers le site ]
◦ Locate and manage credentials. [location of the secrets + list of all files]
◦ Check that the services are running correctly. [command to check all the services]

# 🐳 Inception - User Documentation

Welcome to the Inception infrastructure. This document provides the necessary information to manage, monitor, and use the services provided by this containerized stack.

## 1. Services Overview

The stack provides a full-featured web hosting environment with the following micro-services:

- **NGINX**: The entry point (Reverse Proxy) providing secure HTTPS access (TLS 1.3).
- **WordPress**: The Content Management System (CMS) powered by PHP-FPM.
- **MariaDB**: The relational database for WordPress.
- **Redis**: In-memory cache to accelerate WordPress performance.
- **FTP** (vsftpd): Secure file transfer to manage your website files.
- **Adminer**: A lightweight web interface to manage your database.
- **Static Site**: A simple information page served separately.
- **Fail2ban**: Security layer that monitors logs and bans malicious IPs.


## 2. Getting Started

🚀 Starting the Project

From the root of the repository (~/inception), run:
``` bash
make
```
Alternatively, use: `docker compose up -d --build`

🛑 Stopping the Project

To stop the services without deleting data:
``` bash
make stop
```
To stop and remove all containers and networks:
``` bash
make down
```


## 3. Accessing the Services

To access the services, ensure you have added lflayeux.42.fr to your `/etc/hosts` file.

| Service | Access URL | Credentials |
|---------|------------|-------------|
| Main Website | https://lflayeux.42.fr | Defined in .env
| WP Admin | https://lflayeux.42.fr/wp-admin | Admin User / Password
| Adminer | https://lflayeux.42.fr/adminer | DB User / Password
| Static Site | https://lflayeux.42.fr/static | N/A

## 4. Managing Credentials

Security is handled via Docker Secrets.

- **Location**: All sensitive data is stored in `./conf/secrets/`.

- **Files**:
	- `db_password.txt`: Password for the WordPress database user.
	- `db_root_password.txt`: Password for the MariaDB root user.
	- `wp_admin_password.txt`: Password for the WordPress administrator.

**Environment Variables**: General settings (DB names, usernames, ports)are located in `./conf/env/.env`.

## 5. Health Monitoring

To ensure the infrastructure is healthy, use the following commands:
Check Container Status

``` bash
docker ps
```

All containers should show Up or Up (healthy).
View Service Logs

If a service is not responding, check its logs:

``` bash
docker logs <container_name>
```

Check Fail2ban Status

To see if any attackers have been banned:
Bash

docker exec -it fail2ban fail2ban-client status vsftpd-auth