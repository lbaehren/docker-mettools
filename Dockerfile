FROM ubuntu:16.04

MAINTAINER christian Marquardt <christian@marquardt.sc>

# Update & install development tools

RUN apt-get update --fix-missing && \
    apt-get install -y ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 libxml2 libxml2-dev \
                       libboost-all-dev libnss-wrapper bzip2 curl dos2unix dpkg grep sed make cmake \
                       automake autoconf autotools-dev libtool git gcc g++ gfortran && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tini (see https://github.com/krallin/tini)

RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Anaconda (w/o MKL; see https://docs.continuum.io/mkl-optimizations/index) & add a user

#COPY assets/Anaconda2-4.0.0-Linux-x86_64.sh /tmp
RUN ANACONDA_VERSION=4.0.0-Linux-x86_64 && \
    curl -L "https://repo.continuum.io/archive/Anaconda2-${ANACONDA_VERSION}.sh" > /tmp/Anaconda2-${ANACONDA_VERSION}.sh && \
    export PATH=/opt/conda/bin:$PATH && \
    export CPPFLAGS=-I/opt/conda/include && \
    export LDFLAGS=-L/opt/conda/lib && \
    bash /tmp/Anaconda2-${ANACONDA_VERSION}.sh -b -p /opt/conda && \
    conda install -y nomkl numpy scipy scikit-learn numexpr && \
    conda remove -y mkl mkl-service && \
    conda install -y basemap cheetah libnetcdf netcdf4 mysql-python anaconda-client conda-build && \
    conda update -y --all && \
    conda clean -y --source-cache --index-cache --tarballs && \
    pip install --no-cache-dir alembic && \
    pip install --no-cache-dir conda-workon && \
    pip install --no-cache-dir egenix-mx-base && \
    pip install --no-cache-dir ftputil && \
    pip install --no-cache-dir nose-timer && \
    pip install --no-cache-dir sqlitebck && \
    pip install --no-cache-dir urlgrabber && \
    pip install --no-cache-dir zconfig && \
    mkdir -p /home/conda && \
    conda create --yes --quiet --offline --clone root -p /home/conda/.conda/envs/default && \
    adduser --disabled-password --uid 1001 --gid 0 --gecos "Conda" conda && \
    mkdir -p -m 0775 /home/conda/.jupyter && \
    echo "c.NotebookApp.ip = '*'" >> /home/conda/.jupyter/jupyter_notebook_config.py && \
    chown -R conda /opt/conda && \
    chown -R conda /home/conda && \
    chmod -R u+w,g+w /opt/conda && \
    chmod -R u+w,g+w /home/conda && \
    rm -f /tmp/Anaconda2-${ANACONDA_VERSION}.sh

# Environment variables

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PATH .:/opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /opt/conda/lib:$LD_LIBRARY_PATH

# Add an entrypoint script

COPY assets/entrypoint.sh /sbin

# Switch user

USER 1001

# Entrypoint and default command

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
CMD [ "/bin/bash" ]
