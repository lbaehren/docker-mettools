Mettools Docker image for YAROS and GRAS-PPF
================================================================================


Introduction
-----------------------------------------------------------

This Dockerfile provides the recipe to build an environment where the prototype
`YAROS` (Yet Another Radio Occultation Software) and the operational `GRAS-PPF`
(GRAS Product Processing Facility) can be developed, build, installed and run
(it re-samples the mettools environment used within EUMETSAT).

The environment is given within an `Anaconda` framework which manages all the
additional required dependencies which are not installed via the system package
manager. More details on the dependency management can be found in `docs/02_build.md`.


Principal Steps
-----------------------------------------------------------

In order to be able to use this environment, the following steps are required:

 - Install Docker on your machine (see [Installing Docker on openSUSE](docs/01_install.md)
   for more details)

 - Download the pre-build Docker image from Docker hub (alternatively,
   build it from this repository yourself, see [Building the Anaconda packages and the Docker image](docs/02_build.md) for more details):
   ~~~~
   docker pull marq/anaconda
   ~~~~

 - Run the Docker image (see [Build, Install and Run YAROS and GRAS-PPF](docs/03_run.md)
   for a full example):
   ~~~~
   docker run -it -u $(id -u) marq/anaconda
   ~~~~

 - Work in the default conda environment which contains all the dependencies:
   ~~~~
   source activate /home/conda/.conda/envs/default
   ~~~~

A list of [useful Docker and Anacaonda commands](docs/04_help.md) can be found under `docs/04_help`.


License
-----------------------------------------------------------

TBD


Further reading
-----------------------------------------------------------

 1. [Installing Docker on openSUSE](docs/01_install.md)
 2. [Building the Anaconda packages and the Docker image](docs/02_build.md)
 3. [Build, Install and Run YAROS and GRAS-PPF](docs/03_run.md)
 4. [Organization of files and directories](docs/05_structure.md)
 5. [Useful Docker and Anaconda commands](docs/04_help.md)
