#!/bin/bash -eux

folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${folder}/common.sh"


install_package xorg xserver-xorg desktop-base kde-plasma-desktop plasma-nm systemsettings kscreen kde-config-screenlocker kwin-x11 kmix libkf5dbusaddons-bin kio-extras qml-module-org-kde-newstuff
#install_package sddm kde-config-sddm # this thing is bugged :(
install_package lightdm lightdm-settings desktop-base # desktop-base has themes (grub, lockscreen, login screen, wallpaper)
# in order to be able to run lightdm-settings (eg: change the login screen) you need these also (which with dependencies amount to more than 250 MB)
#install_package python3-gi gobject-introspection gir1.2-gtk-3.0 slick-greeter
install_package kdeconnect kde-spectacle krename ark yakuake
install_package okular okular-extra-backends gwenview kate

