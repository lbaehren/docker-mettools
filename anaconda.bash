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

# Bash functions to simplify the use of the Anaconda docker image
# ---------------------------------------------------------------

# 1. Run bash
# -----------

anabash(){
  docker run -v $PWD:/home/conda/work -w=/home/conda/work --rm -it marq/anaconda /bin/bash "$@"
}

# 2. Run python
# -------------

anapython(){
  docker run -v $PWD:/home/conda/work -w=/home/conda/work --rm -it marq/anaconda python "$@"
}

# 3. Run ipython
# --------------

anaipython() {
  docker run -v $PWD:/home/conda/work -w=/home/conda/work --rm -it marq/anaconda ipython
}

# 4. Run jupyter notebook server
# ------------------------------

ananotebook() {
  #(sleep 3 && open "http://$(docker-machine ip docker2):8888")&
  docker run -v $PWD:/home/conda/work -w=/home/conda/work -p 8888:8888 --rm -it marq/anaconda jupyter notebook --no-browser --notebook-dir=/home/conda/work
}
