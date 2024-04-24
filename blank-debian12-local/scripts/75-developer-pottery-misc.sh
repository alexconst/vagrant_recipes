#!/bin/bash -eux

folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${folder}/common.sh"


# Homebrew
# note: remember, we want it installed in /home/linuxbrew/.linuxbrew since it allows the use of most binary packages (bottles) which will not work otherwise
install_package build-essential git
mkdir /home/linuxbrew
chown $(id -nu 1000):$(id -nu 1000) /home/linuxbrew
runuser -l $(id -nu 1000) -c '/bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'


# improve flatpak integration by exposing dbus interfaces via xdg-desktop-portal
install_package xdg-desktop-portal
# Flatpak
install_package flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Podman
#flatpak install --user flathub io.podman_desktop.PodmanDesktop
install_package_using_brew podman podman-compose podman-tui
install_package uidmap passt # dependencies

