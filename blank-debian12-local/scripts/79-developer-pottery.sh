#!/bin/bash -eux


# Packer and Vagrant
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
apt update
apt install packer
apt install vagrant nfs-kernel-server
# for the vagrant-libvirt plugin, as per https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#ubuntu--debian , you also need the following
apt-get install -y ruby-libvirt
apt-get build-dep vagrant ruby-libvirt
apt-get install -y libvirt-daemon-system ebtables
apt-get install -y --no-install-recommends libguestfs-tools arch-test
runuser -l $(id -nu 1000) -c 'vagrant plugin install vagrant-libvirt'


# Homebrew
# note: remember, we want it installed in /home/linuxbrew/.linuxbrew since it allows the use of most binary packages (bottles) which will not work otherwise
apt-get install --no-install-recommends build-essential git
mkdir /home/linuxbrew
chown $(id -nu 1000):$(id -nu 1000) /home/linuxbrew
runuser -l $(id -nu 1000) -c '/bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'


# improve flatpak integration by exposing dbus interfaces via xdg-desktop-portal
apt-get install -y --no-install-recommends xdg-desktop-portal
# Flatpak
apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Podman
#flatpak install --user flathub io.podman_desktop.PodmanDesktop
brew install podman podman-compose podman-tui

