![docker](https://github.frapsoft.com/bashit/Bash-it_400px_transparent.png)

# bash-it-docker

_Bash Shell v.4.4 with [Bash-it](https://github.com/Bash-it/bash-it), [bats](https://github.com/sstephenson/bats) and [bash-completion](https://github.com/scop/bash-completion) based on [Alpine Linux](https://alpinelinux.org/) as unprivileged User_

[![Build Status](https://travis-ci.org/Bash-it/bash-it-docker.svg?branch=master)](https://travis-ci.org/Bash-it/bash-it-docker) [![Docker Automated Build](https://img.shields.io/docker/automated/ellerbrock/bash-it.svg)](https://hub.docker.com/r/ellerbrock/bash-it/) [![Docker Pulls](https://img.shields.io/docker/pulls/ellerbrock/bash-it.svg)](https://hub.docker.com/r/ellerbrock/bash-it/) [![Quay Status](https://quay.io/repository/ellerbrock/bash-it/status)](https://quay.io/repository/ellerbrock/bash-it) [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg)](https://github.com/ellerbrock/open-source-badges/) [![Gitter Chat](https://badges.gitter.im/frapsoft/frapsoft.svg)](https://gitter.im/Bash-it/bash-it/)

- Docker: [bash-it](https://hub.docker.com/r/ellerbrock/bash-it/)
- Quay: [bash-it](https://quay.io/repository/ellerbrock/bash-it/)

## Info

_Consider this Repository as Work in Progress._  

You can find Documentation how to use and setup Bash-it in the [Main Repository](https://github.com/Bash-it/bash-it).  
Please open only issues related to Docker in this Repository.

## Installation

`docker pull ellerbrock/bash-it`

## About the Container

As Base Image i use [Alpine Linux](https://alpinelinux.org/) which is lightweight Distribution with a small surface area for security concerns, but with enough functionality for development and interactive debugging.

To prevent zombie reaping processes i run [dumb-init](https://github.com/Yelp/dumb-init) as PID 1 which forwards signals to all processes running in the container. 

## Example Usage

**Start a interactive Bash Shell (default)**

`docker run -it ellerbrock/bash-it`

**Use your local `~/.bashrc` settings inside the Container (:ro for read only)**

`docker run -it -v ~/.bashrc:/home/bashit/.bashrc:ro ellerbrock/bash-it`

**Map the current directory inside the Container**

`docker run -it ${PWD}:/data ellerbrock/bash-it`

**Map a [Docker Volume](https://docs.docker.com/engine/tutorials/dockervolumes/)**

`docker run -it myVolName:/app ellerbrock/bash-it`

**Copy Data between Volumes**

```
docker run -it \
  -v import:/import \
  -v export:/export \
 ellerbrock/bash-it -c "cp -R /import/* /export"
```

**Backup a Volume to Disk**

```
docker run -it \
  -v import:/import \
  -v ${PWD}:/export \
ellerbrock/bash-it -c "tar -cvjf /export/backup.tar.bz2 /import/"
```

**Run a Command**

`docker run -it ellerbrock/bash-it -c "ls -alF /"`

**Run as root**

`docker run -it -u root ellerbrock/bash-it`
