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
METTOOLS_VERSION=3.0

#_______________________________________________________________________________
#  Help message with overview of available targets

help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... help                    - Display this help"
	@echo "... clean                   - Clean up (temporary) data"
	@echo "... clean-images            - Clean up Docker images"
	@echo "... clean-volumes           - Clean up Docker containers"
	@echo "... build-all               - Build all Docker images"
	@echo "... build-mettools-ci       - Build Mettools Docker image used form testing and CI"
	@echo "... build-mettools-ubuntu   - Build Mettools Docker using Ubuntu 16.04 with Anaconda"
	@echo "... build-mettools-opensuse - Build Mettools Docker using OpenSuSE 13.2 with Anaconda"
	@echo "... run-mettools-ci         - Run Mettools Docker image used form testing and CI"
	@echo "... run-mettools-ubuntu     - Run Mettools image based on Ubuntu 16.04 and Anaconda"
	@echo "... run-mettools-opensuse   - Run Mettools image based on OpenSuSE 13.2 and Anaconda"
	@echo "... run-opensuse            - Run Docker image for OpenSuSE 13.2"

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

build-all: build-mettools-ci build-mettools-ubuntu build-mettools-opensuse

# ... used for continuous integration

build-mettools-ci:
	cd opensuse/13.2-ci && ${DOCKER_BUILD} -t "mettools-ci:latest-opensuse1302" .

# ... based on OpenSuSE 13.2

build-mettools-opensuse:
	cd opensuse/13.2 && ${DOCKER_BUILD} -t "mettools:${METTOOLS_VERSION}-opensuse1302" .

# ... based on Ubuntu 16.04

build-mettools-ubuntu:
	cd ubuntu/16.04 && ${DOCKER_BUILD} -t "mettools:${METTOOLS_VERSION}-ubuntu1604" .

#_______________________________________________________________________________
#  Run Docker images

run-opensuse:
	docker run -it -v ${BASEDIR}:/home/conda/work "opensuse:13.2" /bin/bash

run-ubuntu:
	docker run -it -v ${BASEDIR}:/home/conda/work "ubuntu:16.04" /bin/bash

run-mettools-ci:
	docker run -it -u ${USERID} -v ${BASEDIR}:/home/mettools/work "mettools-ci:latest-opensuse1302"

run-mettools-opensuse:
	docker run -it -u ${USERID} -v ${BASEDIR}:/home/conda/work "mettools:${METTOOLS_VERSION}-opensuse1302"

run-mettools-ubuntu:
	docker run -it -u ${USERID} -v ${BASEDIR}:/home/conda/work "mettools:${METTOOLS_VERSION}-ubuntu1604"
