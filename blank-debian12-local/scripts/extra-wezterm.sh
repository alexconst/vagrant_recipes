#!/bin/bash


function setup_deps() {
    curl -fsSL https://apt.fury.io/wez/gpg.key | gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    if [[ ! -f "/etc/apt/sources.list.d/wezterm.list" ]]; then
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | tee /etc/apt/sources.list.d/wezterm.list
    fi
}

function install_app() {
    apt-get update
    apt-get install -y --no-install-recommends wezterm
}



if [[ $# -eq 0 ]]; then
    echo "ABOUT: helper script to install software not on debian"
    echo "USAGE: $0 install"
    exit
fi

command="$1"

if [[ "$command" == "install" ]]; then
    setup_deps
    install_app
else
    echo "ERROR: invalid command: $command"
fi

