#!/bin/bash

apt-get update
# install htop because we can
apt-get install -y htop
# dependencies for github-pages
apt-get install -y ruby-dev bundler zlib1g-dev ruby-execjs --no-install-recommends
# dependencies for the pygments syntax highlighter
apt-get install -y python-pygments
# There is a bug which forces us to explicitly install activesupport, which 
# would otherwise be done by the github-pages gem.
# https://github.com/github/pages-gem/issues/181
gem install activesupport
gem install github-pages
apt-get clean

