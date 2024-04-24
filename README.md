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


# How To: VM lifecycle

## vagrant env setup
If you (need to) have `.vagrant.d` in a non-standard location:
```bash
export VAGRANT_HOME=/path/to/your/.vagrant.d
```

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
# connect using SSH
vagrant ssh
vagrant ssh -c 'sudo bash'

# connect using SPICE
vinagre spice://127.0.0.1:5900 2> /dev/null
remmina -c spice://127.0.0.1:5900

# connect using VNC - DEPRECATED
vinagre 127.0.0.1:5900
vinagre vnc://127.0.0.1:5900 2> /dev/null
xtigervncviewer 127.0.0.1:5900
remmina -c vnc://127.0.0.1:5900
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


# How To: box lifecycle

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




# Troubleshooting

## no spice nor vnc connection
Vagrant is bugged and is not populating the libvirt xml properly. To fix it:
```bash
vagrant halt

virsh list --all
virsh edit blank-debian12-local_default
```
Then edit the graphics section to have:
```xml
<graphics type='spice' keymap='en-us' autoport='yes'>
    <listen type='address' address='127.0.0.1'/>
</graphics>
```


