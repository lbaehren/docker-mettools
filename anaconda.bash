# Bash functions to simplify the use of the Anaconda docker image
# ---------------------------------------------------------------

# 1. Run bash
# -----------

anabash(){
  docker run -v $PWD:/home/devel/work -w=/home/devel/work --rm -it marq/anaconda-nomkl /bin/bash "$@"
}

# 2. Run python
# -------------

anapython(){
  docker run -v $PWD:/home/python/work -w=/home/python/work --rm -it marq/mettools python "$@"
}

# 3. Run ipython
# --------------

mtipython() {
  docker run -v $PWD:/home/python/work -w=/home/python/work --rm -it marq/mettools ipython
}

# 4. Run jupyter notebook server
# ------------------------------

mtjupyter() {
  #(sleep 3 && open "http://$(docker-machine ip docker2):8888")&
  docker run -v $PWD:/home/python/work -w=/home/python/work -p 8888:8888 --rm -it marq/mettools jupyter notebook --no-browser --ip="\*" --notebook-dir=/home/python/work
}
