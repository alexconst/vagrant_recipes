#!/bin/bash -eux

function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

function install_zsh {
    install_package zsh
    mkdir -p /tmp/zsh
    cd /tmp/zsh
    # install_package zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting
    cd zsh-syntax-highlighting
    make install
    cd ..
    # install_package zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions
    cd zsh-autosuggestions
    rm zsh-autosuggestions.zsh
    make
    install -c -d /usr/share/zsh-autosuggestions
    cp zsh-autosuggestions.zsh /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    cd ..
    # install_package zsh-theme-powerlevel9k # powerlevel9k is now legacy and 10k is not on debian
    mkdir -p /usr/local/share/fonts/MesloNF
    pushd .
    cd /usr/local/share/fonts/MesloNF
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    fc-cache -f -v
    popd
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/zsh-powerlevel10k
    cd ..
}

function install_tmux {
    install_package tmux
    # this ensures the latest version of the plugin
    runuser -l $(id -nu 1000) -c 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
}

# network
install_package iputils-ping dnsutils wget ca-certificates curl

# utils
install_package bc jq ncdu gpm man-db stow

# useful tools include in the debian "standard system utilities" task package without the useless stuff
install_package file lsof bzip2 xz-utils dnsutils whois net-tools tcpdump

# shell
install_package coreutils make git # required to pull and install latest zsh and tmux addons
install_zsh
install_tmux

