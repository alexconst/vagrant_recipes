# About

Some Vagrant recipes.

- **blank-trusty64-atlas**:
    - blank slate environment.
    - uses Vagrant box from Hashicorp Atlas.
- **dummy-jessie64-own**:
    - dummy environment.
    - custom made box created using Packer.
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
