#--------------------------------------------------------------------------------
# MetTools - A Collection of Software for Meteorology and Remote Sensing
# Copyright (C) 2016  EUMETSAT
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#--------------------------------------------------------------------------------

BASEDIR=`pwd`/..
USERID=`id -u`
TIMESTAMP=`date +%Y%m%d`
DOCKER_BUILD=docker build --rm=true --force-rm
VERSION_OPENSUSE="13.2"

#_______________________________________________________________________________
#  Help message with overview of available targets

help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... help                    - Display this help"
	@echo "... clean                   - Clean up (temporary) data"
	@echo "... clean-images            - Clean up Docker images"
	@echo "... clean-volumes           - Clean up Docker containers"
	@echo "... build-all               - Build all Docker images"
	@echo "... build-mettools-ubuntu   - Build Mettools Docker using Ubuntu 16.04 with Anaconda"
	@echo "... build-mettools-opensuse - Build Mettools Docker using OpenSuSE ${VERSION_OPENSUSE} with Anaconda"
	@echo "... run-mettools-ubuntu     - Run Mettools image based on Ubuntu 16.04 and Anaconda"
	@echo "... run-mettools-opensuse   - Run Mettools image based on OpenSuSE ${VERSION_OPENSUSE} and Anaconda"

#_______________________________________________________________________________
#  Clean-up : keep in mind that Docker will keep quite a few data on disk,
#             there running the risk to run out of space.

clean: clean-volumes clean-images

# Remove Docker images
clean-volumes:
	for IMG in `docker ps -a -q` ; { docker stop $$IMG ; } ;
	for IMG in `docker ps -a -q` ; { docker rm -f $$IMG ; } ;

# Remove Docker containers
clean-images:
	for IMG in `docker ps -a -q` ; { docker stop $$IMG ; } ;
	for IMG in `docker images -q` ; { docker rmi -f $$IMG ; } ;

#_______________________________________________________________________________
#  Build Docker image(s)

build-all: build-mettools-ubuntu build-mettools-opensuse

# ... based on OpenSuSE 13.2

build-mettools-opensuse:
	${DOCKER_BUILD} -f opensuse/${VERSION_OPENSUSE}/Dockerfile -t "mettools:opensuse-${VERSION_OPENSUSE}" .

# ... based on Ubuntu 16.04

build-mettools-ubuntu:
	${DOCKER_BUILD} -f ubuntu/16.04/Dockerfile -t "mettools:ubuntu-16.04" .
	${DOCKER_BUILD} -f ubuntu/14.04/Dockerfile -t "mettools:ubuntu-14.04" .

#_______________________________________________________________________________
#  Run Docker images

run-mettools-opensuse:
	docker run -it -u ${USERID} -v ${BASEDIR}:/home/conda/work "mettools:opensuse-${VERSION_OPENSUSE}"

run-mettools-ubuntu:
	docker run -it -u ${USERID} -v ${BASEDIR}:/home/conda/work "mettools:ubuntu-16.04"
