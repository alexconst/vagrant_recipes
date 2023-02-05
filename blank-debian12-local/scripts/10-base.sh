#!/bin/bash -eux

apt-get -y update

apt-get install -y --no-install-recommends aptitude
apt-get install -y --no-install-recommends nfs-common
apt-get install -y vim-nox
apt remove -y vim-tiny
apt-get install -y htop


