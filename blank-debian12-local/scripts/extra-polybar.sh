#!/bin/bash

version="3.7.1"
polybar="polybar-$version"


function install_deps() {
    apt-get install -y --no-install-recommends g++ cmake pkg-config libuv1-dev libcairo2-dev python3-sphinx
    apt-get install -y --no-install-recommends xcb-proto python3-xcbgen libxcb1-dev libxcb-util-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev  libxcb-ewmh-dev libxcb-icccm4-dev 
    apt-get install -y --no-install-recommends libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libpulse-dev libasound2-dev libjsoncpp-dev libcurl4-openssl-dev libnl-genl-3-dev
}

function get_src() {
    wget https://github.com/polybar/polybar/releases/download/$version/$polybar.tar.gz
    tar -xzf $polybar.tar.gz
}

function build() {
    cd $polybar
    mkdir -p build
    cd build
    cmake ..
    make -j$(nproc)
}

function install() {
    apt-get remove -y polybar # remove any previous version first
    cd $polybar/build
    make install
}




if [[ $# -eq 0 ]]; then
    echo "ABOUT: helper script to build polybar from source. It downloads the source to current folder and builds it there."
    echo "USAGE: $0 COMMAND"
    echo "List of commands:"
    cat "$0" | grep '^function' | sed 's#function #    #g ; s#().*{##g'
    exit
fi

command="$1"

if [[ "$command" == "install_deps" ]] || [[ "$command" == "install" ]]; then
    if [[ "$UID" -gt 0 ]]; then
        echo "ERROR: should run as root"
    else
        eval $command
    fi
elif [[ "$command" == "get_src" ]] || [[ "$command" == "build" ]]; then
    if [[ "$UID" -eq 0 ]]; then
        echo "ERROR: should run as user"
    else
        eval $command
    fi
else
    echo "ERROR: invalid command; $command"
fi


