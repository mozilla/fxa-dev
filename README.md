# AWS Ansible-based development environment for Firefox Accounts

## Prerequisites

- [ansible](http://docs.ansible.com/intro_installation.html) >=1.5
- [boto](https://github.com/boto/boto#installation)

## Usage

To run on AWS change directory to `aws`

```sh
cd aws
```

1. Set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
3. create a `environments/foo.yml` file ('foo' can be anything)
  a) see `environments/EXAMPLE.yml` for a base reference
  b) it is recommended that you set values for `owner` and `reaper_spare_me`
4. run `make foo`

To updated the stack just run `make foo` again.

You can ssh into the EC2 instance with `ssh ec2-user@meta-{{ whatever you configured in foo.yml }}`

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
- content server: https://latest.dev.lcip.org
- auth server: https://latest.dev.lcip.org/auth/
- oauth server: https://oauth-latest.dev.lcip.org
- sync tokenserver: https://latest.dev.lcip.org/syncserver/token/1.0/sync/1.5
- demo oauth site: https://123done-latest.dev.lcip.org
- ssh access: ec2-user@meta-latest.dev.lcip.org
