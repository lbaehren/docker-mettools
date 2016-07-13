Useful Docker and Anaconda commands
===================================


Overview
--------

This help file consists of the following topics:
 - Useful Docker commands
 - Useful Docker memory clean-up commands
 - Useful Anaconda commands

Related websites:
 - [EUMETSATs Dockerfile source repository](https://github.com/cmarquardt/docker-anaconda)
 - [EUMETSATs Docker image hub](https://hub.docker.com/r/marq/anaconda/)
 - [EUMETSATs Anaconda package cloud](https://anaconda.org/Eumetsat/packages)
 - [EUMETSATs GitLab source code server (Anaconda recipes, YAROS, GRAS-PPF)](https://gitlab.eumetsat.int/)

Useful Docker commands
----------------------

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



Useful Docker memory clean-up commands
--------------------------------------

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



Useful Anaconda commands
------------------------

Get information about the Anaconda environment:
~~~~
conda info
conda info --envs
~~~~

List all installed Anaconda packages of the currently
active virtual Anaconda environment:
~~~~
conda list
~~~~

Activate a Anaconda virtual environment:
~~~~
source activate <environment-name-or-path-to-environment>
~~~~
e.g.:
~~~~
source activate /home/conda/.conda/envs/myenv
~~~~
The path to this environment is prepended to the PATH env variable. The
path is also available via the CONDA_DEFAULT_ENV env variable.
Note that the `root` environment (`source activate root`) is
equivalent to not activate any environment at all.

Deactivate the currently active virtual Anaconda environment
(basically returning to the root environment):
~~~~
source deactivate
~~~~

Search for an Anaconda package (on the default Anaconda channel):
~~~~
conda search <package-name>
~~~~
If one wish to also search packages on other channels than the
default one, one should specify it with `-c` (e.g. `-c eumetsat`).

Install a new package:
~~~~
conda install <package-name>
~~~~
In addition, the channel and version can be specified as well, e.g. as
following:
~~~~
conda install -c eumetsat libnetcdf-c=4.4.1
~~~~

There are basically three ways how to create a new virtual Anaconda environment.

When creating a new virtual Anaconda environment, make sure not to clone
or specify any conda root packages (in particular `conda`, `conda-build`
and `conda-env`) otherwise you will not be able to install new packages in that
environment, and you will get the following error message: "Error: 'conda' can
only be installed into the root environment".

First way: Create it from scratch by providing a list of packages
to be installed:
~~~~
conda create -p <path-to-new-environment> <package-list>
~~~~
e.g.:
~~~~
conda create -p /home/conda/.conda/envs/myenv nomkl sqlite matplotlib
~~~~
with `-p` the path to the new environment. It will also install all packages
it depends on. In this particular case, it will install all packages without
MKL support since the `nomkl` package is specified as well.

If packages from other channels than the Anaconda default channel should be
installed, specify these channels as well (with the `-c` option). It searches
the packages in the given order the channels are provided, so the default Anaconda
channel should be explicitly listed first (if desired), e.g.:
~~~~
conda create -c defaults -c eumetsat -c conda-forge -p /home/conda/.conda/envs/myenv mettools-base=3.0 mettools=3.0
~~~~

Instead of using the `-p` path option one can also use the `-n` name option
to create a new environment:
~~~~
conda create -n <name-of-new-environment> <package-list>
~~~~
e.g.:
~~~~
conda create -n myenv nomkl sqlite matplotlib
~~~~

Second way: Instead of using the list of packages in the command itself,
it is also possible to provide a file with the list of packages:
~~~~
conda create -n <name-of-new-environment> --file <filename-with-list-of-packages>
~~~~

The list of currently installed packages can be exported as following:
~~~~
conda list --export -n <name-of-environment> > <filename>
~~~~

Third way: Cloning an environment from an existing one:
~~~~
conda create --clone <name-of-existing-environment> -n <name-of-new-environment>
~~~~

In order to build a new Anaconda package, it is necessary to
create a `meta.yaml` file with some meta information about the
package and a `build.sh` script with the build instructions (see
e.g. EUMETSATs GitLab repository `ro/anaconda-recipes` for examples).
In addition, `pre-link.sh`, `post-link.sh` and `pre-unlink.sh` scripts
can be provided as well.

The package can then be build and uploaded as following:
~~~~
conda-build .
anaconda upload -u <user> <path-to-tar-file>
~~~~

Pip installed packages can also be converted to Anaconda packages:
~~~~
conda skeleton pypi <package>
conda build .
~~~~






