# AWS Ansible-based docker development environment for Firefox Accounts

## Prerequisites

- [ansible](http://docs.ansible.com/intro_installation.html) >=2.2
- [boto](https://github.com/boto/boto#installation) >=2.6

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

After the cloudformation stacks has been created, `cloud-init` will run an
initial `ansible` playbook to set up the box. A cronjob run every 10 minutes
will pick up changes as needed. The logs for the initial playbook run are in
`/var/log/cloud-init-output.log`. If the cloudformation was created OK, but
the services do not come up, check that log output for why.

You can ssh into the EC2 instance with `ssh ec2-user@meta-{{ whatever you configured in foo.yml }}`.

Docker tags: By default, the `latest` tag will be used. This can be adjusted
to use other image tags by setting any of `{auth_docker_tag,
authdb_docker_tag, basket_proxy_docker_tag, content_docker_tag,
customs_docker_tag, oauth_docker_tag, profile_docker_tag, rp_docker_tag}` in
your environments/foo.yml configuration file. (NOTE: you must commit and push
changes to that file to affect an existing EC2 instance).

## Layout Notes

- fxa sources are in `/data/fxa-dev`.
- node processes are run by docker
  - config is setup by ansible `docker_container` module (e.g., roles/auth/tasks/main.yml)
  - run `docker ps; docker images` for info
- ansible will do a docker pull, and restart the container if the image, or configuration, has changed.
- nginx is the web frontend
  - config in `/etc/nginx/conf.d`
- node process logs are available with, e.g., `docker logs auth-server`.

## Example urls

- content server: https://latest.dev.lcip.org
- auth server: https://latest.dev.lcip.org/auth/
- oauth server: https://oauth-latest.dev.lcip.org
- profile server: https://latest.dev.lcip.org/profile
- demo oauth site: https://123done-latest.dev.lcip.org
- ssh access: ec2-user@meta-latest.dev.lcip.org
