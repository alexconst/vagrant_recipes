#!/bin/bash -eux

function install_package {
    apt-get install -y --no-install-recommends "$@"
    #echo "$@"
}

function install_sessionmanager {
    install_package lightdm lightdm-settings desktop-base
    # desktop-base has themes (grub, lockscreen, login screen, wallpaper), otherwise the login will have bad visibility
}

function install_i3_blocks {
    install_package i3blocks sysstat
}

function install_i3_polybar {
    install_package polybar
}

# these are pretty much bare mininum
function install_goodies {
    #install_package lxappearance lxde-settings-daemon # Note: run lxappearance and choose theme materia-dark and icons gnome-wise-icon-theme
    # deprecating the above in turn of my own dotfile and xfce
    install_package gtk2-engines gtk2-engines-pixbuf materia-gtk-theme papirus-icon-theme paper-icon-theme gnome-icon-theme gnome-wise-icon-theme
    #install_package volumeicon-alsa # for `volumeicon` -- pasystray is more powerful
    install_package pasystray # for pulse audio `pasystray`
    install_package policykit-1-gnome # for elevating user process permissions

    install_package parcellite # clipboard
    install_package orage sox # for `orage` calendar app (more powerful than `gsimplecal`)
    install_package network-manager-gnome # for `nm-applet`
}

function install_goodies_xfce {
    install_package xfce4-settings # for all sorts of config including display
    install_package xfce4-clipman # for `xfce4-clipman`, but I can use parcellite instead
    install_package xfce4-terminal # note: I should just use `tmux` instead; another alternative is `terminator`
}

# these give a full WM/DE experience
function install_goodies_hardware {
    install_package xfce4-power-manager xfce4-power-manager-plugins # for `xfce4-power-manager`
    install_package blueman # for `blueman-applet`
}


install_package xserver-xorg xinit
install_package xfonts-100dpi xfonts-75dpi xfonts-scalable
install_package i3 i3lock i3status dunst suckless-tools dwm rofi xdotool xdo wmctrl

# NOTE: can potentially comment out this one since I can either run xrandr manually or use the autostart file:
#   .config/autostart/xrandr-autostart.desktop
#   xrandr --output Virtual-1 --mode 1920x1080
install_package lxrandr

install_sessionmanager
#install_i3_blocks
install_i3_polybar
install_goodies
#install_goodies_xfce
#install_goodies_hardware

