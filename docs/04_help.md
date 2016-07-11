Useful Docker commands
======================

Memory clean-up
---------------

Container cleanup (first stops all running containers and then removes them):

~~~~
docker ps -a -q
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
~~~~

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
docker rmi <image-id>
~~~~

Remove only all untagged images:

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

 - Docker Cloud account


TBD



