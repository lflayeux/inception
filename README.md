# :whale: INCEPTION

This project has been created as part of the **42 curriculum** by :

|Avatar|Profile|
|-|--|
|<img src="https://github.com/lflayeux.png" width="40"> | [lflayeux](https://github.com/lflayeux)

## :scroll: SUMMARY

[TOC]

## :notebook_with_decorative_cover: PROJECT DESCRIPTION

This project aims to set up a small infrastructure with different services : nginx, mariadb, php-fpm
It aim to learn us how to use docker and contianers efficiently and how volume and networks works in docker.
Todo so we build 3 containers interconnect with 2 database

Here you can find important differences to understand to do the project

### 1. Virtual Machines vs Docker

A virtual machine simulate an entire machine so it recreate a kernel new volume etc based on the ressourcres avalaible on the host.
Docker chare the kernel of the host machine 

### 2. Secrets vs Environment Variables

A **Secret** is a file containing sensitive data (like passwords or API keys). Instead of storing the password directly in an **Environment Variable** which is insecure because it can be seen via `docker inspect` we store the path to the secret file.

When the container starts, Docker mounts the secret into a temporary memory-based filesystem (`/run/secrets/`). This ensures that sensitive data is never exposed in the container's configuration or stored permanently on the disk.

### 3. Docker Network vs Host Network

Docker network is an entire network inside docker with his own dns to transltate ip inside the docker network to name of the service

### 4. Docker Volumes vs Bind Mounts

Docker volumes stocks the data in a 

## :hammer_and_wrench: Instructions

To use our program make sure you got docker preinstalled by using:
```bash
docker --version
```

if not installed follow the step on the official [docker installation guide](https://docs.docker.com/engine/install/).

Next step is to clone this repo on your device:

```bash
git clone <reponame> <name_of_your_destination>
```

> :warning: choose the place wisely

then go ont the folder and to execute the project use:
```bash
make
```

go to `https://lflayeux.42.fr` you can now see your website connect to it, let commentary etc...

## Instructions

### Prerequisites
To run this project, you need a **Virtual Machine** (Debian or Ubuntu is recommended) with the following tools installed:
* **Docker** & **Docker Compose**
* **GNU Make**
* **OpenSSL** (for SSL/TLS certificate generation)

### Configuration
1.  **Local Domain Setup**: 
    Modify your `/etc/hosts` file on your host machine to map the project domain to your local loopback address:
    ```bash
    echo "127.0.0.1 lflayeux.42.fr" | sudo tee -a /etc/hosts
    ```
2.  **Environment Variables**:
    Create a `.env` file in the `srcs/conf/env/` directory. This file must contain all necessary credentials (DB names, users, passwords).
    > [!IMPORTANT]
    > Never commit the `.env` file or any files within the `secrets/` directory to your Git repository.

### Installation & Execution
Navigate to the root of the project and use the provided **Makefile**:

| Command | Action |
| :--- | :--- |
| `make` | Builds the Docker images and starts all containers in the background. |
| `make stop` | Stops the running containers without removing them. |
| `make clean` | Stops and removes containers and the internal network. |
| `make fclean` | Full cleanup: removes containers, networks, **and all persistent volumes/data**. |
| `make re` | Performs a full reset and rebuilds the entire infrastructure. |

### Accessing the Services
Once the infrastructure is up and the healthchecks are green, you can access the services via your web browser:

* **WordPress**: [https://lflayeux.42.fr](https://lflayeux.42.fr)
* **Adminer**: [https://lflayeux.42.fr/adminer](https://lflayeux.42.fr/adminer)
* **Static Site**: [https://lflayeux.42.fr/static](https://lflayeux.42.fr/static)
* **FTP**: Connect via `ftp lflayeux.42.fr` on port **21** using the credentials defined in your `.env`.
## :book: DOCUMENTATION

|Resource|Type|Description|
|:------:|----|-----------|
| [Docker](https://docs.docker.com)	| *Documentation* | Docker official documentation				|
| [Nginx](https://nginx.org/en/docs/)							| *Documentation* | Nginx official documentation				|
| [Docker certification](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker)			| *Certification* | Helsinki University Docker Certification	|
| [SSL/TLS](https://www.cloudflare.com/fr-fr/learning/ssl/how-does-ssl-work/) 						| *Documentation* | Understanding of TLS protocol				|
| [OpenSSL](https://quennec.fr/trucs-astuces/syst%C3%A8mes/gnulinux/commandes/openssl/openssl-g%C3%A9n%C3%A9rer-un-certificat-auto-sign%C3%A9)						| *Documentation* | OpenSSL auto signed certification documentation				|
| [WP-CLI](https://make.wordpress.org/cli/handbook/guides/) | *Documentation* | WP-CLI official documentation |
| [MariaDB](https://mariadb.com/docs) | *Documentation* | MariaDB official documentation |
| [ShellCheck](https://www.shellcheck.net/) | *Tools* | Bash/sh script checker |
| [Bash cheat sheet](https://devhints.io/bash) | *CheatSheet* |  Bash scripting cheatsheet |
| [Bash script styleguide](https://google.github.io/styleguide/shellguide.html) | *Styleguide* | Official Google bash scripting styleguide |
| [Network CheatSheet](https://www.geeksforgeeks.org/computer-networks/computer-network-cheat-sheet/) | *CheatSheet* | Computer Network CheatSheet |