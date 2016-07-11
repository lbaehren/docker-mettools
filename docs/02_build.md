Building the Anaconda packages and the Docker image
===================================================

Overview
--------

This file covers the following topics:

 - Building the required dependencies as Anaconda packages
 - Build the Docker image which requires the Anaconda packages

Before starting, make sure you have the following accounts
with the required access rights:

 - `EUMETSAT GitLab` account with read access to `ro/anaconda-recipes`
 - `Anaconda cloud` account with write access to the `EUMETSAT channel`
 - `Docker hub` account with acces to `marq/anaconda` (admin only)


Building the required dependencies as Anaconda packages
-------------------------------------------------------

In order to build up the environment where YAROS and GRAS-PPF can be
developed, build, installed and run, there are several packages
required which are not available via the system or anaconda package
manager. These packages need to be build from source.

The way these sources are managed here is by providing them as
ancaonda packages. Each source is build with `conda build` and
the resulting installable package is uplaoded to the Anaconda
cloud from where it can be downloaded later for the docker
image build.

The anaconda recipes for building each package are currently 
managed within the EUMETSAT GitLab repository
`git@gitlab.eumetsat.int:ro/anaconda-recipes.git`
and contains (besides others) the following important build recipes:
`bufrdc`, `grib api`, `epsar`, `eugene`, `fftw3`, `libnetcdf-c`,
`libnetcdf-cxx4`, `libnetcdf-fortran` and `ropp`. They need to be
build in the right order within an Anaconda environment. One can
either use a local anaconda installation to build the packages
or use the Docker image build from this repository (and eventually
remove the `conda install -c eumetsat ...` instructions of the
packages which do not exist yet).

A typical workflow for building and uploading an Anaconda package would
be as following (assuming Anaconda is installed and one has access to the
anaconda-recipes repository):

Check out the Anaconda recipes repository:
~~~~
git clone git@gitlab.eumetsat.int:ro/anaconda-recipes.git
~~~~

Make sure that Anaconda is installed:
~~~~
conda info
~~~~

Build a package from source, e.g.:
~~~~
cd anaconda-recipes/eugene/
conda build .
~~~~

Make sure that the source as given in the `meta.yaml` file for each package
still exists. The package is then build in a separate minimal Anaconda environment
according to the `build.sh` build script. If others than the minimal packages
are required, then they need to be listed in the `meta.yaml` file as dependencies
(this includes e.g. also explicitly the python version to be used). In order
to find external packages during the build, the external channel need to be
provided to the build command (e.g. `conda build -c eumetsat .`).


If the build was successful, the installable package can be uploaded
to the desired Anaconda cloud channel (requires an account with write
access to that channel), e.g. for the EUMETSAT channel:
~~~~
anaconda upload -u eumetsat /opt/conda/conda-bld/linux-64/eugene-4.20-1.tar.bz2
~~~~

If the build fails, one may have a look on the build script `build.sh` and
the `meta.yaml` file again.

The uploaded package can now be installed in any anaconda environment
via e.g.:
~~~~
conda install -c eumetsat eugene=4.20
~~~~


Building the Docker image which requires the Anaconda packages
--------------------------------------------------------------

After all the Anaconda packages where the docker build depends on are build
and uploaded, the Docker image can be build using the Dockerfile (and added
resources) as maintained in this repository.

Currently, the Docker hub is connected to this repository in a way 
so that as soon as a new commit is pushed to this repository a new
docker image is build on Docker hub using the updated repository.

The latest Docker image can then be downloaded directly from
the public Docker hub as following (no account required):
~~~~
docker pull marq/anaconda
~~~~

It assumes that Docker is installed (cf. `docs/01_install`).If one want
to build the Dockerfile locally, one can check out a working copy
(using Git) or unpacking the source archive of this repository, and
build the Dockerfile as following:
~~~~
git clone https://github.com/cmarquardt/docker-anaconda.git
docker build --rm=true --force-rm -t marq/anaconda .
~~~~

The Docker image can now be run in a Docker container as dscribed
in `docs/03_run`.


