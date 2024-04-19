#!/bin/bash -eux

folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${folder}/common.sh"


function install_zsh {
    install_package zsh
    mkdir -p /tmp/zsh
    cd /tmp/zsh
    # install_package zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting
    cd zsh-syntax-highlighting
    PREFIX=/usr make install
    cd ..
    # install ZSH_HIGHLIGHT_STYLES highlight settings that work with solarized theme
    src="https://raw.githubusercontent.com/dracula/zsh-syntax-highlighting/master/zsh-syntax-highlighting.sh"
    dst="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting_colorscheme-dracula.zsh"
    curl "$src" > "$dst"
    # install_package zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions
    cd zsh-autosuggestions
    rm zsh-autosuggestions.zsh
    make
    install -c -d /usr/share/zsh-autosuggestions
    cp zsh-autosuggestions.zsh /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    cd ..
    # install powerlevel10k for zsh (it replaces the legacy powerlevel9k)
    # the recommended font is Meslo Nerd Font patched for Powerlevel10k
    # to check for glyphs see https://www.nerdfonts.com/cheat-sheet
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
#install_package git-lfs # installing with homebrew a newer version due to a potential bug in Debian's version
install_zsh
#install_tmux # skipping here because we want the latest which is not available in Bookworm, so we install with brew

