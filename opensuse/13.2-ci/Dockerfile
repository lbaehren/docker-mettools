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

MAINTAINER Lars Baehren "lars.baehren@cgi.com"

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
        libaio1 \
        sed \
        sqlite3-devel \
        openssh

#_______________________________________________________________________________
# Tini (see https://github.com/krallin/tini)

RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.rpm" > tini.rpm && \
    rpm -i tini.rpm && \
    rm tini.rpm

#_______________________________________________________________________________
#  Install NSS wrapper library required for entrypoint script

RUN zypper --non-interactive install cmake && \
    curl https://ftp.samba.org/pub/cwrap/nss_wrapper-1.1.3.tar.gz -o nss_wrapper-1.1.3.tar.gz && \
    tar -xzf nss_wrapper-1.1.3.tar.gz && \
    cd nss_wrapper-1.1.3 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf nss_wrapper-1.1.3* && \
    zypper --non-interactive remove cmake

#_______________________________________________________________________________
# Add a user

RUN useradd --uid 1001 --create-home --gid 0 --comment "MetTools" mettools && \
    chown -R mettools /home/mettools && \
    chmod -R u+w,g+w /home/mettools

#_______________________________________________________________________________
# Set environment variables:

ENV HOME /home/mettools

# At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*,
# and that's not OK (see: http://bugs.python.org/issue19846).
ENV LANG C.UTF-8

#_______________________________________________________________________________
# Switch user:

USER 1001
WORKDIR /home/mettools

#_______________________________________________________________________________
# Add an entrypoint script and an Anaconda global config file:

COPY entrypoint.sh /sbin
COPY .condarc /home/mettools

#_______________________________________________________________________________
# Entrypoint and default command:

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
CMD [ "/bin/bash" ]
