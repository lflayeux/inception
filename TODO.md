# :white_check_mark: TODO

- [x] lflayeux.42.fr must redirect to localhost

### DOCKER_COMPOSE.YML


- [x] container for nginx
- [x] container for mariadb
- [x] container for wordpress + php/fpm
- [x] volume for wordpresse database
- [ ] volume for wordpress website files (store data in /home/lflayeux/data)
- [x] docker network to connect each container
> :warning: Your containers have to restart in case of a crash

- [x] add docker_ignore git_ignore
- [ ] dossier /home/lflayeux/data pour volumes 
 
### DOCKERFILE NGINX

- [x] based on alpine penultimate
- [x] tls v1.2/1.3
- [ ]


### DOCKERFILE MARIADB

- [x] based on alpine penultimate
- [ ]


### DOCKERFILE WORDPRESS + PHP FPM

- [x] based on alpine penultimate
- [x] tls v1.2/1.3
- [ ] WordPress database with two user administrator + user. 

> :warning: The admin username can’t contain admin/Admin or administrator/Administrator (e.g., admin, administrator, Administrator admin-123, and so forth).


### README.MD

- [x] first line must be italicized and read: This project has been created as part of the 42 curriculum by <login1>[, <login2>[, <login3>[...]]].
- [x] “Description” section that clearly presents the project, including its goal and a brief overview.
- [x] An “Instructions” section containing any relevant information about compilation, installation, and/or execution.
- [x] A “Resources” section listing classic references related to the topic (documentation, articles, tutorials, etc.), as well as a description of how AI was used specifying for which tasks and which parts of the project.
- [x] A Project description section must also explain the use of Docker and the sources included in the project. It must indicate the main design choices, as well as a comparison between:
◦ Virtual Machines vs Docker
◦ Secrets vs Environment Variables
◦ Docker Network vs Host Network
◦ Docker Volumes vs Bind Mounts



### USER_DOC.MD

This file must explain, in clear and simple terms, how an end user or administrator can:
- [ ] Understand what services are provided by the stack.
- [ ] Start and stop the project.
- [ ] Access the website and the administration panel.
- [ ] Locate and manage credentials.
- [ ] Check that the services are running correctly.


### DEV_DOC.MD

This file must describe how a developer can:
- [ ] Set up the environment from scratch (prerequisites, configuration files, secrets).
- [ ] Build and launch the project using the Makefile and Docker Compose.
- [ ] Use relevant commands to manage the containers and volumes.
- [ ] Identify where the project data is stored and how it persists


