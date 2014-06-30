.PHONY: default

default: latest

%:
	ansible-playbook -i localhost, dev.yml --extra-vars "stack_name=$@"
