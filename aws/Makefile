.PHONY: default

default: latest

%:
	PYTHONUNBUFFERED=1 ansible-playbook -i localhost, dev.yml --extra-vars "stack_name=$@"
