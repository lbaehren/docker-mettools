#!/bin/bash
# Override user ID lookup to cope with randomly assigned user IDs with the
# -u option to 'docker run'.
#
# This entrypoint is slightly modified from the orginal version at
#
#   http://blog.dscpl.com.au/2015/12/unknown-user-when-running-docker.html
#
# and was originally written by Graham Dumpleton.
#

# 1. Override any forced users
# ----------------------------

USER_ID=$(id -u)
if [ x"$USER_ID" != x"0" -a x"$USER_ID" != x"1001" ]; then
    NSS_WRAPPER_PASSWD=/tmp/passwd.nss_wrapper
    NSS_WRAPPER_GROUP=/tmp/group.nss_wrapper
    cat /etc/passwd | sed -e 's/^conda:/builder:/' > $NSS_WRAPPER_PASSWD
    echo "conda:x:$USER_ID:0:Conda,,,:/home/conda:/bin/bash" >> $NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_GROUP
    LD_PRELOAD=/usr/lib/libnss_wrapper.so
    export LD_PRELOAD
fi

# 2. Define default conda environment
# -----------------------------------

source activate /home/conda/.conda/envs/default

# 3. Run tini
# -----------

exec tini -- "$@"
