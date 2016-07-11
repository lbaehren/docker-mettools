Installing Docker on openSUSE
=============================

Starting with openSUSE 13.2, `docker` rpms are available from the standard repositories,
but typically not in the most recent version. Current versions of the docker engine as
well as additional tools like `docker-compose`, `docker-swarm` and `docker-machine` are
thus available through a dedicated openSUSE build project:
[Virtualization:containers](https://build.opensuse.org/project/show/Virtualization:containers).

Therefore, the above build project needs to be made known to the openSUSE system configuration via
~~~~
zypper addrepo http://download.opensuse.org/repositories/Virtualization:/containers/openSUSE_13.2/Virtualization:containers.repo
~~~~

Once this repository is available, docker packages can be installed with:
~~~~
zypper install docker
zypper install docker-bash-completion 
zypper install docker-compose
zypper install docker-swarm 
zypper install docker-machine 
~~~~

and started via
~~~~
systemctl start docker
~~~~

The automatic restart of the docker daemon can be configured with
~~~~
systemctl enable docker
~~~~

Users who would like to use docker must be members of the `docker` user group; this must
be set up by system administrators, as EUMETSAT's group and user information is managed
centrally via NIS. This is equivalent to run
~~~~
usermod -a -G docker <username>
~~~~
on a stand-alone machine. Here, `<username>` is, obviously, the user's Unix account name.

There might be additional information at
[Docker's installation page for openSUSE](https://docs.docker.com/engine/installation/linux/SUSE/).
