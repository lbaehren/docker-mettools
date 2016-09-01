Organization of files and directories
=====================================================================================

After checking out a working copy (using Git) or unpacking the source archive,
you will be left with the following directory structure:

    .
    ├── anaconda.bash         ...  Collection of helper functions to work with Docker image
    ├── assets
    │   └── entrypoint.sh     ...  Script to define the entry point into the Docker image
    ├── docs                  ...  Expanded documentation
    │   ├── 01_install.md
    │   ├── 02_build.md
    │   ├── 03_run.md
    │   ├── 04_help.md
    │   └── 05_structure.md
    ├── Makefile              ...  Tasks for building and running Docker images
    ├── README.md             ...  Top-level README file
    ├── opensuse              ...  Docker images based on the OpenSuSE Linux distribution
    │   ├── 13.2
    │   │   ├── assets
    │   │   │   └── entrypoint.sh
    │   │   └── Dockerfile
    │   └── 13.2-ci
    │       ├── Dockerfile
    │       └── entrypoint.sh
    └── ubuntu                ...  Docker images based on the OpenSuSE Linux distribution
        └── 16.04
            ├── assets
            │   └── entrypoint.sh
            └── Dockerfile


assets
-----------------------------------------------------------

Originally intended as common area for storing resources (assets) used across all of
the created Docker images; however due to limitation in the configuration for automated
builds on Docker Hub - where especially the `-f` option is not supported - this setup
cannot not be used generally and asses have been moved into the directories containing
the Docker build scripts.


docs
-----------------------------------------------------------

This directory contains some expanded documentation on the creation and usage of the 
Docker images provided through this project. The documentation contains:

 1. Instructions on how to install and start docker on openSUSE;
 2. Instructions on how to build the Docker image and the required Anaconda packages;
 3. Full examples on how to build, install and run YAROS and GRAS-PPF using this Docker image;
 4. Collection of useful Docker and Anaconda commands;
 5. Organization of files and directories.


opensuse / ubuntu
-----------------------------------------------------------

Instruction to build Docker images based on the OpenSuSE and Ubuntu Linux distributions.
Individual image directories are organized by distribution version (e.g '16.04') and
and flavors (full configuration, minimal configuration for continuous integration).
