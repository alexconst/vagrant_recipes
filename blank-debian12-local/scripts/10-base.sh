#!/bin/bash -eux

apt-get -y update

apt-get install -y --no-install-recommends aptitude libdpkg-perl libfile-fcntllock-perl
apt-get install -y --no-install-recommends nfs-common
apt-get install -y vim-nox
apt remove -y vim-tiny
apt-get install -y htop

# NOTE: the existence of this folder broke the installation of a kernel (as part of the initramfs -u phase), so I'm removing it... hopefully it won't break anything... TBC
rmdir /etc/udev/rules.d/70-persistent-net.rules

