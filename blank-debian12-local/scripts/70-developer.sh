#!/bin/bash -eux

function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

install_package git python3-pip python3-dev python3-venv
# pipenv python3-virtualenv
install_package gcc colormake build-essential dpkg-dev fakeroot

