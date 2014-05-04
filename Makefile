.PHONY: local local-vmware

local: packer/sl64-virtualbox.box
	vagrant up --provider=virtualbox

local-vmware: packer/sl64-vmware.box
	vagrant up --provider=vmware_fusion --no-provision
	sleep 300
	vagrant provision

packer/sl64-vmware.box: packer/sl64.json
	cd $(dir $<); \
	packer build -only=vmware-iso sl64.json

packer/sl64-virtualbox.box: packer/sl64.json
	cd $(dir $<); \
	packer build -only=virtualbox-iso sl64.json

.PHONY: update-code update

update-code:
	ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory local.yml --tags code

update:
	ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory local.yml

.PHONY: destroy

destroy:
	vagrant destroy -f
