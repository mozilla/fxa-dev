.PHONY: default vmware

default:
	vagrant up --provider=virtualbox

vmware:
	vagrant up --provider=vmware_fusion

.PHONY: update-code update

update-code:
	ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --private-key=./insecure_private_key -u vagrant --tags code local.yml

update:
	vagrant provision

.PHONY: destroy

destroy:
	vagrant destroy -f
