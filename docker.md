## Autostart / Fail recovery Service
```bash
# /etc/init/app.conf
description "calendar app"
author "stavros liaskos"
start on (started docker)
stop on runlevel [!2345]
# Automatically Respawn with finite limits
respawn
respawn limit 99 15
respawn limit unlimited
script
        docker run -d -p 9090:80 --name calendar_app -v /home/developer/calendar_app/html:/app/ k0st/alpine-apache-php
end script
```

## Commands
```bash
init-checkconf app.conf     # validate conf file
sudo service app restart    # activate upstart service
```

## Commit, export and load image
```bash
docker commit -m "updated pes" -a "Stavros Liaskos"  ee4g8s6c95c1 update/pes:v1
docker images
docker save -o ./pes_v1.tar update/pes
```

## Dockerfile example
```bash
# adding nano to tiny alpine container
FROM k0st/alpine-apache-php   # /home/developer
MAINTAINER Stavros Liaskos    # comments are allowed ONLY in the start of the line!
RUN apk --update add nano
ENV TERM=xterm
```

## Build image
```bash
# build image (note trailing '.')
docker build -t apache/php:nano .
# use that image
docker run -d -p 9090:80 --name calendar_app -v /home/developer/calendar_app/html:/app/ apache/php:nano 
# ssh to the container
docker exec -it calendar_app /bin/sh
```

## Commands
```bash
docker build -t calendar_app .  #builds image. the "." in the end points to the current directory
docker run -d -p 9090:80 --name calendar_app -v "$PWD"/html:/var/www/html/ php:7.0-apache
docker run -d -p 9090:80 --name calendar_app -v "$PWD"/html:/app/ k0st/alpine-apache-php
docker exec -ti -u root container_name bash   # run the container as root!
docker inspect containerName
```

## Links
[Update error solution](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/issues/1905)  
[Dockerfiles explained](https://gist.github.com/thaJeztah/e6f00c7ef51897358103e1496f572ae1)