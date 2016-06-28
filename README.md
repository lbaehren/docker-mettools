Docker image using Anaconda
===========================


## Introduction

t.b.w.


## Organization of files and directories

After checking out a working copy (using Git) or unpacking the source archive,
you will be left with the following directory structure:

    .
    ├── anaconda.bash         ...  Collection of helper functions to work with Docker image.
    ├── assets
    │   └── entrypoint.sh     ...  Script to define entry point into the Docker image.
    ├── Dockerfile            ...  Docker file used for building Docker image.
    └── README.md             ...  This Readme file.


## Requirements

 - Resolve external dependencies for building and running YAROS.
 - Resolve external dependencies for building and running GRAS-PPF-SG.


## Open questions

 - What extactly should be part of the Docker image and what should not?
 - What are possible manners of working with the Docker image?
 - Naming scheme for tagging the image?
