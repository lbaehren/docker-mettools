Mettools Docker image for YAROS and GRAS-PPF
============================================


Introduction
------------

This Dockerfile provides the recipe to build an environment where the prototype
`YAROS` (Yet Another Radio Occultation Software) and the operational `GRAS-PPF`
(GRAS Product Processing Facility) can be developed, build, installed and run
(it re-samples the mettools environment used within EUMETSAT).

The environment is given within an `Anaconda` framework which manages all the
additional required dependencies which are not installed via the system package
manager. More details on the dependency management can be found in `docs/02_build.md`.


Principal Steps
---------------

In order to be able to use this environment, the following steps are required:

 - Install Docker on your machine (see `docs/01_install.md`)

 - Download the pre-build Docker image from Docker hub (alternatively,
   build it from this repository yourself, see `docs/02_build.md`):
   ~~~~
   docker pull marq/anaconda
   ~~~~

 - Run the Docker image (see `docs/03_run.md` for a full example):
   ~~~~
   docker run -it -u $(id -u) marq/anaconda
   ~~~~

 - Work in the default conda environment which contains all the dependencies:
   ~~~~
   source activate /home/conda/.conda/envs/default
   ~~~~

A list of useful Docker and Anacaonda commands can be found under `docs/04_help`.


Organization of files and directories
-------------------------------------

After checking out a working copy (using Git) or unpacking the source archive,
you will be left with the following directory structure:

    .
    ├── anaconda.bash       ...  Collection of helper functions to work with Docker image.
    ├── assets
    │   └── entrypoint.sh   ...  Script to define the entry point into the Docker image.
    ├── docs
    │   ├── 01_install.md   ...  Instructions on how to install and start docker on openSUSE.
    │   ├── 02_build.md     ...  Instructions on how to build the Docker image and the required Anaconda packages.
    │   ├── 03_run.md       ...  Full examples on how to build, install and run YAROS and GRAS-PPF using this Docker image.
    │   └── 04_help.md      ...  Useful Docker and Anaconda commands.
    ├── Makefile            ...  Tasks for building and running Docker images
    ├── README.md           ...  This Readme file.
    ├── opensuse
    │   └── 13.2
    │       └── Dockerfile
    └── ubuntu
        └── 16.04
            └── Dockerfile



License
-------

TBD


