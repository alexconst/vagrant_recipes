#!/bin/bash

apt-get update
# install htop because we can
apt-get install -y htop
# make sure we have dependencies
apt-get install -y ruby-dev bundler bsdtar zlib1g-dev
apt-get clean

# install Vagrant (not required since the vagrant gem from github will be installed)
#cd /tmp/
#curl -LO https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
#dpkg -i vagrant_1.8.1_x86_64.deb

# expects you to have cloned your fork to /vagrant/
cd /vagrant/vagrant-aws/
# installs both vagrant and the vagrant-aws plugin using bundle
bundle
bundle exec rake


