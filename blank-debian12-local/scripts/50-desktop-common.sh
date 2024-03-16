#!/bin/bash -eux

function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

function install_font_awesome {
    # package fonts-font-awesome is too old so instead we install it manually
    cd /tmp
    wget https://use.fontawesome.com/releases/v6.4.0/fontawesome-free-6.4.0-desktop.zip
    unzip fontawesome-free-6.4.0-desktop.zip
    mkdir -p /usr/local/share/fonts/
    mv fontawesome-free-6.4.0-desktop /usr/local/share/fonts/
    fc-cache -f -v
}

function install_font_nerd {
    cd /tmp/
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/DejaVuSansMono.zip
    unzip DejaVuSansMono.zip -d nerd
    mkdir -p /usr/local/share/fonts/
    mv nerd /usr/local/share/fonts/nerdfonts-dejavusansmono-3.0.0
    fc-cache -f -v
}

install_package x11-utils x11-xserver-utils xclip
install_package mesa-utils # for glxinfo, glxgears
install_package dbus-user-session dbus-x11
install_package usb.ids
install_package fontconfig xfonts-base fonts-dejavu fonts-dejavu-core fonts-dejavu-extra fonts-lmodern fonts-stix
install_package fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji
install_font_awesome
install_font_nerd
install_package gvim-gtk3 firefox-esr libgd3 pulseaudio pavucontrol alsa-utils
install_package ffmpeg feh sxiv
install_package mpv smplayer smplayer-themes # vlc
install_package ntfs-3g p7zip-full rar unrar zstd rsync gpg


# vpn
install_package wireguard openresolv

# terminal
install_package rxvt-unicode
install_package xterm xtermcontrol xtermset

# other goodies
## xcwd: useful for launching applications directly into the same directory as the focused application
## xsel: for clipboard access between the cli and X
install_package xcwd xsel


