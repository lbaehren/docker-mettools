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

# Get current user id. The current user id is either randomly assigned or set by
# the 'USER' statement in the dockerfile (e.g. in this case 'USER 1001'). It can
# also be provided via the docker run command option '-u' (e.g. '-u 2200'). If a
# directory is mounted with the run command option '-v' it is recommended to
# provide the user id of the host directory (e.g. '-u $(id -u)') otherwise you
# will not have write access on the mounted directory.
USER_ID=$(id -u)

# If you run as root ('-u 0') or as the default user (without '-u' or '-u 1001')
# as defined in the dockerfile, wrapping is not required. It is however not
# recommended to run it as root.
if [ x"$USER_ID" != x"0" -a x"$USER_ID" != x"1001" ]; then

    # Define wrapper passwd file. The group file needs no modification.
    NSS_WRAPPER_PASSWD=/tmp/passwd.nss_wrapper
    NSS_WRAPPER_GROUP=/etc/group

    # Copy passwd file and change the user name of the default user so that we
    # can destingish files created by the default user and the current user
    # (both will be in the same group).
    cat /etc/passwd | sed -e 's/^mettools:/builder:/' > $NSS_WRAPPER_PASSWD

    # Add a new passwd database file entry for the current user with name
    # 'mettools' and group id '0' so that it can also modify files from the default
    # user (and mounted directories if the provided user id matches the host one).
    echo "mettools:x:$USER_ID:0:mettools,,,:/home/mettools:/bin/bash" >> $NSS_WRAPPER_PASSWD

    # Preload wrapper shared library so that for all processes subsequently
    # running the wrapped passwd file is used.
    export NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_GROUP
    if [ -f /opt/mettools/lib/libnss_wrapper.so ] ; then
        LD_PRELOAD=/opt/mettools/lib/libnss_wrapper.so
    fi
    if [ -f /usr/local/lib/libnss_wrapper.so ] ; then
        LD_PRELOAD=/usr/local/lib/libnss_wrapper.so
    fi
    export LD_PRELOAD
fi


# 2. Define default mettools environment
# -----------------------------------

# Set PS1 variable so that the prompt can be correctly restored when
# deactivating the mettools environment activated below.
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

# 3. Run tini
# -----------

exec tini -- "$@"

