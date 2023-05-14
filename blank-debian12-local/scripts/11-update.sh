#!/bin/bash -eux

# update list of packages
apt-get -y update
# upgrades packages but does not remove any packages
apt-get -y upgrade
# upgrades packages and may remove packages
apt-get -y full-upgrade
# removes any packages no longer needed
apt-get -y autoremove
# clean repository of packages that no longer exist
apt-get -y autoclean


