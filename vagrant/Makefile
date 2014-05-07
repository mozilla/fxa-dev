.PHONY: default vmware

default: packer/sl64-virtualbox.box destroy
	vagrant up --provider=virtualbox

vmware: packer/sl64-vmware.box destroy
	vagrant up --provider=vmware_fusion

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

.PHONY: distclean

distclean:
	rm packer/sl64-virtualbox.box
	rm packer/sl64-vmware.box
	vagrant box remove sl64 --provider=virtualbox
	vagrant box remove sl64 --provider=vmware_desktop
