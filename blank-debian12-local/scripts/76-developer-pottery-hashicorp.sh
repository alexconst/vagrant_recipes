#!/bin/bash -eux

folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${folder}/common.sh"


# Packer and Vagrant
install_package lsb-release
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update
install_package_with_recommends packer
install_package_with_recommends vagrant nfs-kernel-server
# for the vagrant-libvirt plugin, as per https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#ubuntu--debian , you also need the following
install_package_with_recommends ruby-libvirt
apt-get build-dep vagrant ruby-libvirt
install_package_with_recommends libvirt-daemon-system ebtables
install_package libguestfs-tools arch-test
runuser -l $(id -nu 1000) -c 'vagrant plugin install vagrant-libvirt'


