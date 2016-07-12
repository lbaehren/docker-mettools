Useful Docker commands
======================


General
-------

Check the docker environment:
~~~~
docker info
~~~~

Search for an image (locally and on Docker hub):
~~~~
docker search <image-name>
~~~~

Download an image:
~~~~
docker pull <image-name>:<version>
~~~~

List all local images:
~~~~
docker list
~~~~

List all running containers:
~~~~
docker ps
~~~~

Inspect an image or a container (e.g. to obtain the IP-address):
~~~~
docker inspect <name-of-image-or-container>
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <name-of-running-container>
~~~~

Build an image from a docker file (assuming that there is a
`Dockerfile` in the current directory):
~~~~
docker build -t <name-of-new-image> .
~~~~

Run an image independently, e.g.:
~~~~
docker run <image-name>
~~~~

Run an image in interactive mode, e.g.:
~~~~
docker run --rm -it <image-name> /bin/bash
~~~~

Run an image in detached mode, e.g.:
~~~~
docker run -d <image-name> /bin/sh -c <command-to-execute>
~~~~

Log into a running container with another shell:
~~~~
docker ps
docker exec -it <container-name-or-id>
~~~~

Login into Docker hub:
~~~~
docker login --username=<your-username>
~~~~

Push an image to Docker hub:
~~~~
git push <image-name>:<version>
~~~~



Memory clean-up
---------------

Container cleanup (first stops all running containers and then removes them):
~~~~
docker ps -a -q
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
~~~~
WARNING: It will remove all containers from all users on this machine!

Image cleanup (first stops and removes all containers which potentially use the images):
~~~~
docker images -a -q
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
~~~~
WARNING: It will remove all images from all users on this machine!

In order to remove individual images, do the following:
~~~~
docker rmi <image-name-or-id>
~~~~

Remove only all un-tagged images:
~~~~
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
~~~~

Remove dangling images:
~~~~
docker rmi $(docker images -q --filter "dangling=true")
~~~~

Remove (dangling) volumes:
~~~~
docker volume ls
docker volume ls -f dangling=true
docker volume rm <volume-id>
~~~~



Short Docker tutorial
---------------------

Before starting, make sure you have the following accounts
with the required access rights:

 - A `Docker Cloud` account

TBD



