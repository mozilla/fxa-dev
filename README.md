# Development environment for Firefox Accounts

## Prerequisites

- [packer](http://www.packer.io/downloads.html)
- [vagrant](http://www.vagrantup.com/downloads.html)
- [ansible](http://docs.ansible.com/intro_installation.html)
- vmware [fusion](https://www.vmware.com/products/fusion/) or [workstation](http://www.vmware.com/products/workstation)

## Usage

Running `make` will:

- build a base vagrant box image
- create a cluster of virtual machines
- provision each machine with a role
- set an entry for `fxa.local` in `/etc/hosts`

The fxa-content-server should now be accessible from a browser at `http://fxa.local`

To pull code changes from github:

```sh
make update-code
```

To update other provisioning changes:

```sh
make update
```
