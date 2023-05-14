#!/bin/bash -eux

apt-get -y update

apt-get install -y --no-install-recommends spice-vdagent

# TODO: check if --no-install-recommends should be used or not
apt-get install -y --no-install-recommends xserver-xorg-video-qxl

