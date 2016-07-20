#--------------------------------------------------------------------------------
# MetTools - A Collection of Software for Meteorology and Remote Sensing
# Copyright (C) 2016  EUMETSAT
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#--------------------------------------------------------------------------------

FROM opensuse:13.2

MAINTAINER Lars Baehren "lbaehren@gmail.com"

##______________________________________________________________________________
##  Updates w.r.t. the base image

RUN zypper --non-interactive update && \
    zypper --non-interactive install wget nano ncurses-devel

##______________________________________________________________________________
##  Install packages required for GRAS-PPF

RUN zypper --non-interactive install -t pattern devel_C_C++ ; \
    zypper --non-interactive install \
        boost-devel \
        curl \
        doxygen \
        gcc \
        gcc-c++ \
        gcc-fortran \
        git \
        gitk \
        bzip2 \
        grep \
        make \
        automake \
        libgfortran3 \
        libxerces-c-devel \
        libxml2 \
        libxml2-devel \
        sed \
        sqlite3-devel

#_______________________________________________________________________________
# Tini (see https://github.com/krallin/tini)

RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm" > tini.rpm && \
    rpm -i tini.rpm && \
    rm tini.rpm

#_______________________________________________________________________________
# Add a user

RUN useradd --uid 1001 --create-home --gid 0 --comment "Conda" conda
ENV HOME=/home/conda

#_______________________________________________________________________________
# Install Miniconda and create a default environment with all the required
# packages needed to build and run YAROS and GRAS-PPF (w/o MKL; see
# https://docs.continuum.io/mkl-optimizations/index):

RUN MINICONDA_VERSION=latest-Linux-x86_64 && \
    curl -L "https://repo.continuum.io/miniconda/Miniconda2-${MINICONDA_VERSION}.sh" > /tmp/Miniconda2-${MINICONDA_VERSION}.sh && \
    export PATH=/opt/conda/bin:$PATH && \
    export CPPFLAGS=-I/opt/conda/include && \
    export LDFLAGS=-L/opt/conda/lib && \
    bash /tmp/Miniconda2-${MINICONDA_VERSION}.sh -b -p /opt/conda && \
    conda install -y conda-build && \
    conda install -y -c eumetsat nss_wrapper && \
    conda create  -y -c defaults -c eumetsat -c conda-forge -p /home/conda/.conda/envs/default mettools-base=3.0 mettools-ro=3.0 && \
    bash -c "source activate /home/conda/.conda/envs/default && \
       pip install --no-cache-dir alembic && \
       pip install --no-cache-dir egenix-mx-base && \
       pip install --no-cache-dir ftputil && \
       pip install --no-cache-dir nose-timer && \
       pip install --no-cache-dir --global-option=build_ext --global-option="-I/home/conda/.conda/envs/default/include" sqlitebck && \
       pip install --no-cache-dir urlgrabber && \
       pip install --no-cache-dir zconfig" && \
    conda clean -y --source-cache --index-cache --tarballs && \
    chown -R conda /home/conda && \
    chmod -R u+w,g+w /home/conda && \
    rm -f /tmp/Miniconda2-${MINICONDA_VERSION}.sh


#_______________________________________________________________________________
# Set environment variables:

# At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*,
# and that's not OK (see: http://bugs.python.org/issue19846).
ENV LANG C.UTF-8

ENV PATH .:/opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /opt/conda/lib:$LD_LIBRARY_PATH

ENV EUGENE_HOME /home/conda/.conda/envs/default/share/eugene/
ENV BUFR_TABLES /home/conda/.conda/envs/default/share/bufrdc/bufrtables/


#_______________________________________________________________________________
# Add a notebook profile:

RUN mkdir -p -m 0775 /home/conda/.jupyter && \
    echo "c.NotebookApp.ip = '*'" >> /home/conda/.jupyter/jupyter_notebook_config.py


#_______________________________________________________________________________
# Switch user:

USER 1001
WORKDIR /home/conda


#_______________________________________________________________________________
# Ensure that our default conda environment is always activated when starting a
# new bash shell and that the name of the environment is shown as part of the prompt:

RUN bash -c "echo -e '\n# activate default Anaconda environment' >> ~/.bashrc" && \
    bash -c "echo -e 'source activate default\n' >> ~/.bashrc"


#_______________________________________________________________________________
# Add an entrypoint script and an Anaconda global config file:

COPY assets/entrypoint.sh /sbin
COPY assets/.condarc /opt/conda


#_______________________________________________________________________________
# Entrypoint and default command:

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
CMD [ "/bin/bash" ]

