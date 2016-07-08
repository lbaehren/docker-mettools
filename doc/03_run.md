Build, Install and Run YAROS and GRAS-PPF
=========================================

Setup
-----

Before starting, make sure you have the following accounts
with the required access rights:

 - EUMETSAT GitLab account with read access to ro/yaros
 - EUMETSAT GitLab account with read access to ro/gras-ppf


Create a directory where to put the YAROS and GRAS-PPF source code:
~~~~
cd <home>
mkdir development
~~~~

Obtain YAROS source code:
~~~~
cd development
git clone git@gitlab.eumetsat.int:ro/yaros.git
cd yaros
git checkout features/prepare-anaconda
cd ../..
~~~~

Obtain GRAS-PPF source code:
~~~~
cd development
git clone git@gitlab.eumetsat.int:ro/gras-ppf.git
cd gras-ppf
git submodule init
git submodule update
cd src/napeos
git checkout master
cd ../../../..
~~~~


Run the Docker image in a container
-----------------------------------

Check that the Docker image is available (if not it will be
automatically downloaded in the next step):
~~~~
docker images
~~~~

Run the Docker image in a Docker container:
~~~~
docker run -rm -it -u $(id -u) -v <home>/development:/home/conda/development marq/anaconda
~~~~
The option -v mounts the local directory with the YAROS and GRAS-PPF
source code into the container and with -u $(id -u) you will be the
same user in the container as on the host system. This allows to modify
files on the mounted directory.

Alternatively, one can source `anaconda.bash` and use their provided
bash functions for other means of running the Docker image.


YAROS use example
-----------------

Start the Docker image in a Docker container as described in the previous
step and activate the `default` conda environment which contains all the
required dependencies.
~~~~
source activate /home/conda/.conda/envs/default
~~~~

Now, install YAROS into this environment:
~~~~
cd ~/development/yaros
make maintainerclean
./autogen.sh
./configure
make install
~~~~

Check that it is actually installed:
~~~~
conda list
~~~~

Run the YAROS test suite where all tests should pass:
~~~~
make test
~~~~


GRAS-PPF use example
--------------------

TBD



Possible manners of working with the Docker image
-------------------------------------------------

TBD







