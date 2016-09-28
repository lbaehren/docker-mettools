MetTools Docker image
================================================================================


Introduction
-----------------------------------------------------------

This Dockerfile provides the recipe to build a Docker image which contains
an environment which re-samples the MetTools environment used within EUMETSAT.

The environment is given within an `Anaconda` framework which manages all the
additional required dependencies which are not installed via the system package
manager. The complete documentation can be found on 
[EUMETSATs GitLab Server](https://gitlab.eumetsat.int/ro/mettools).


Principal Steps
-----------------------------------------------------------

In order to be able to use this environment, the following steps are required:

 - Install Docker on your machine.

 - Download the pre-build Docker Ubuntu or OpenSuSE image from Docker Hub 
   (alternatively, build it from this repository yourself):
   ~~~~
   docker pull eumetsat/mettools:latest-ubuntu-16.04
   docker pull eumetsat/mettools:latest-opensuse-13.2
   ~~~~

 - Run the Ubuntu or OpenSuSE Docker image and work on the default conda environment:
   ~~~~
   docker run -it -u $(id -u) eumetsat/mettools:latest-ubuntu-16.04
   docker run -it -u $(id -u) eumetsat/mettools:latest-opensuse-13.2
   ~~~~


Organization of Files and Directories
-----------------------------------------------------------

After checking out a working copy (using Git) or unpacking the source archive,
you will be left with the following directory structure:

    .
    ├── opensuse                  ... Docker images based on the OpenSuSE Linux distribution
    │   ├── 13.2
    │   │   ├── assets
    │   │   │   ├── .condarc      ... Conda configuration file
    │   │   │   └── entrypoint.sh ... Script to define the entry point into the Docker image
    │   │   └── Dockerfile
    │   └── 13.2-ci
    │       ├── Dockerfile
    │       └── entrypoint.sh
    ├── ubuntu                    ... Docker images based on the Ubuntu Linux distribution
    │   └── 16.04
    │       ├── assets
    │       │   └── entrypoint.sh
    │       └── Dockerfile
    ├── Makefile                  ... Tasks for building and running Docker images
    ├── README.md                 ... This README file
    └── anaconda.bash             ... Collection of helper functions to work with Docker image


General Comments
-----------------------------------------------------------

Assets: Originally intended as common area for storing resources (assets) used across all
of the created Docker images. However due to limitation in the configuration for automated
builds on Docker Hub - where especially the `-f` option is not supported - this setup
cannot be used generally and assets have been moved into the directories containing
the Docker build scripts.

OpenSuSE / Ubuntu: This repository contains instruction to build Docker images based
on the OpenSuSE and Ubuntu Linux distributions. Individual image directories are organized
by distribution version (e.g '16.04') and flavors (full configuration and minimal
configuration for continuous integration).


License
-----------------------------------------------------------

TBD

