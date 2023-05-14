# About

## Naming convention
Format: purpose-OS-vendor
Example: blank-debian11-local => minimal / bare bones install, debian 11, locally build using Packer (previous boxes use the word "own" instead of "local")
Example: blank-jessie64-aws => minimal / bare bones install, debian jessie, AWS image

## Vagrant recipes

- **blank-trusty64-atlas**:
    - blank slate environment.
    - uses Vagrant box from Hashicorp Atlas.
- **blank-jessie64-own**:
    - blank state environment.
    - installs some survival packages: htop, aptitude, vim, git
    - uses custom made box created using Packer.
- **dummy-jessie64-own**:
    - dummy environment used in tutorial.
    - uses custom made box created using Packer.
- **github_pages-wily64-atlas**:
    - Blog in a box! Installs GitHub Pages gem with its specific Jekyll version.
    - uses Vagrant box from Hashicorp Atlas.
- **github_pages-ansible-wily64-atlas**:
    - blog in a box! Installs GitHub Pages gem with its specific Jekyll version.
    - uses Vagrant box from Hashicorp Atlas.
    - uses Ansible for provisioning.
- **blank-jessie64-aws**
    - blank slate environment.
    - uses AWS AMI.
    - includes a Vagrantfile capable of reading AWS credential files. Could be useful until [PR #441](https://github.com/mitchellh/vagrant-aws/pull/441) gets merged.
- **vagrant_dev-wily64-atlas**
    - development environment suitable for hacking on the vagrant-aws plugin.
    - uses Vagrant box from Hashicorp Atlas.


# How To VM lifecycle

## create VM
```bash
# deploy the VM the first time:
vagrant up

# reload settings from Vagrantfile
# (it shuts down the VM, spins it back up, but doesn't do the provisioning unless you force them with the --provision flag)
vagrant reload

# get status of VM (if created, stopped, suspended, etc)
vagrant status
```

## connect to VM
```bash
# connect to the VM
vagrant ssh

# connect over VNC
vinagre 127.0.0.1:5900
xtigervncviewer 127.0.0.1:5900
```


## stop/start and suspend/resume VM
```bash
# power off the VM
vagrant halt
# power on the VM
vagrant up

# suspend/sleep the VM
vagrant suspend
# resume VM
vagrant resume
```

## delete VM
```bash
# get the state of all active Vagrant environments
vagrant global-status --prune

# destroy all resources that were created during the machine creation process
vagrant destroy $vm
```


# How To box lifecycle

## add a box to the pool
```bash
vagrant box add "${boxfile}" --name "${boxname}"
vagrant box list
```

## remove a box from the pool
```bash
# to check the status of all your vagrant machines
vagrant global-status --prune

# delete box
vagrant box list
vagrant box remove $box
# for libvirt boxes/images you also have to:
virsh vol-list --pool default
rm $image_file
ls -la /var/lib/libvirt/images/
```

