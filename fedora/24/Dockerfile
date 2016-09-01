FROM fedora:24

MAINTAINER Lars Baehren "lbaehren@gmail.com"

##______________________________________________________________________________
##  Updates w.r.t. the base image

RUN dnf -y update && \
    dnf clean all && \
    dnf -y install \
        wget \
        nano \
        ncurses-devel && \
    dnf -y install \
        @development-tools \
        tar \
        boost-devel \
        cmake \
        expat-devel \
        fftw3-devel \
        gcc-c++ \
        gcc-gfortran \
        gsl-devel \
        lapack-devel \
        netcdf-cxx-devel \
        netcdf-fortran-devel \
        openldap-devel \
        python-devel \
        sqlite-devel \
        udunits2-devel \
        xerces-c-devel && \
    dnf clean all

#    libudunits2-dev \
#    liblog4cxx10-dev \
#    sqlite3

WORKDIR /tmp/data

COPY assets/bufrdc /tmp/data/bufrdc
COPY assets/Makefile /tmp/data/Makefile
RUN make cmake bufr distclean

##______________________________________________________________________________
##  Create user account & generate SSH key

RUN make adduser
USER 1001
WORKDIR /home/grasppf
