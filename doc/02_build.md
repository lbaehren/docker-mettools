Building the Anaconda packages and the Docker image
===================================================

Overview
--------

This readme file covers the following topics:

 - Building the required dependencies as anaconda packages
 - Build the Docker image which requires the anaconda packages
 - Dependency management and naming convention


Building the required dependencies as anaconda packages
-------------------------------------------------------

In order to build up the environment where YAROS and GRAS-PPF can be
devoloped, build, installed and run, there are several packages
required which are not available via the system or anaconda package
manager. These packages need to be build from source.

The way these sources are managed here is by building each source
with `conda build` and upload the resulting installable package
to the anaconda cloud where it can be downloaded again.

The anaconda recipes for building each package are managed at the
following EUMETSAT repository:
~~~~
git@gitlab.eumetsat.int:ro/anaconda-recipes.git
~~~~
and contains (besides others) the following important dependencies:
`bufrdc`, `grib api`, `epsar`, `eugene`, `fftw3`, `libnetcdf-c`,
`libnetcdf-cxx4`, `libnetcdf-fortran` and `ropp`. They need to be
build in the right order within an anaconda environment.










Build the Docker image which requires the anaconda packages
-----------------------------------------------------------

In order to build the docker image from this dockerfile, all the 



Dependency management and naming convention
-------------------------------------------

Naming scheme for tagging the image?

What extactly should be part of the Docker image and what should not?






