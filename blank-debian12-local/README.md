# About

Debian 12 (Bookworm) box with NFS share enabled. Due to an issue between Debian and Vagrant we are forced to used NFS v3.
Note that if you have an NFS server running or a populated `/etc/exports` config file around then Vagrant will default to using NFS, however its default options may be incompatible with your server, hence the need to specify the sync folder method details.

The box referenced by this recipe was built locally using Packer.

