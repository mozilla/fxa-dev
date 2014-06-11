# Development environment for Firefox Accounts

## Prerequisites

For a local virtual machine environment:

- [vagrant](http://www.vagrantup.com/downloads.html) >=1.5
- [ansible](http://docs.ansible.com/intro_installation.html) >=1.5
- [virtualbox](https://www.virtualbox.org/wiki/Downloads) or vmware ([fusion](https://www.vmware.com/products/fusion/) or [workstation](http://www.vmware.com/products/workstation))

For an AWS environment:

- [ansible](http://docs.ansible.com/intro_installation.html) >=1.5
- [boto](https://github.com/boto/boto#installation)

## Usage

### Local

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

### AWS

To run on AWS change directory to `aws`

```sh
cd aws
```

1. Set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
2. create a `my_vars.yml` file
3. run `make`

To updated the stack just run `make` again.

You can ssh into the EC2 instance with `ssh ec2-user@{{ whatever you configured in my_vars.yml }}`

## Layout Notes

- fxa sources are in `/data/fxa-*`
- node processes are run by supervisord
  - config in `/etc/supervisor.d`
  - run `sudo supervisorctl status` for info
- nginx is the web frontend
  - config in `/etc/nginx/conf.d`
- node process logs are in `/var/log/fxa-*`

## Example urls

- logs: https://latest.dev.lcip.org/logs/
- heka: https://latest.dev.lcip.org/heka/
- content server: https://latest.dev.lcip.org
- auth server: https://latest.dev.lcip.org/auth/
- oauth server: https://oauth-latest.dev.lcip.org
- demo oauth site: https://123done-latest.dev.lcip.org
