# Development environment for Firefox Accounts

## Prerequisites

For a local virtual machine environment:

- [packer](http://www.packer.io/downloads.html)
- [vagrant](http://www.vagrantup.com/downloads.html)
- [ansible](http://docs.ansible.com/intro_installation.html)
- [virtualbox](https://www.virtualbox.org/wiki/Downloads) or vmware ([fusion](https://www.vmware.com/products/fusion/) or [workstation](http://www.vmware.com/products/workstation))

For an AWS environment:

- [ansible](http://docs.ansible.com/intro_installation.html)
- [boto](https://github.com/boto/boto#installation)

## Usage

To run a local virtual machine evironment change directory to `vagrant`

```sh
cd vagrant
```

Running `make` or `make vmware` will:

- build a base vagrant box image
- create a cluster of virtual machines
- provision each machine with a role
- set an entry for `fxa.local` in `/etc/hosts`

The fxa-content-server should now be accessible from a browser at [http://fxa.local](http://fxa.local)

To pull code changes from github:

```sh
make update-code
```

To update other provisioning changes:

```sh
make update
```
