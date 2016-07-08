Docker image using Anaconda
===========================


Introduction
------------

This Dockerfile provides the recipe to build an environment where the prototype Yaros ()
and the operational GRAS-PPF () can be developed, build, installed and run.

The environment is given within the anaconda framework which manages all the additional
required dependencies which are not installed via the system package manager.

More details on the dependancy management can be found in docs/02_build.md.


Principal Steps
---------------

In order to be able to use this environment the following steps are required:

 - Install docker on your machine

 - Download this docker image:


In order to build the docker image from this dockerfile, all the 




Organization of files and directories
-------------------------------------

After checking out a working copy (using Git) or unpacking the source archive,
you will be left with the following directory structure:

    .
    ├── anaconda.bash         ...  Collection of helper functions to work with Docker image.
    ├── assets
    │   └── entrypoint.sh     ...  Script to define entry point into the Docker image.
    ├── Dockerfile            ...  Docker file used for building Docker image.
    └── README.md             ...  This Readme file.


Requirements
------------

 - Resolve external dependencies for building and running YAROS.
 - Resolve external dependencies for building and running GRAS-PPF-SG.


Open questions
--------------

 - What extactly should be part of the Docker image and what should not?
 - What are possible manners of working with the Docker image?
 - Naming scheme for tagging the image?
