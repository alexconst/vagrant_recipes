#!/bin/bash -eux

folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${folder}/common.sh"


install_package git python3-pip python3-dev python3-venv
# pipenv python3-virtualenv
install_package gcc colormake build-essential dpkg-dev fakeroot

