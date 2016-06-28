# Bash functions to simplify the use of the Anaconda docker image
# ---------------------------------------------------------------

anabuild(){
    docker build -t "anaconda:ubuntu-16:04" .
}

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
