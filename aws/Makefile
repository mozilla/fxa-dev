.PHONY: default

default: latest

%:
	PYTHONUNBUFFERED=1 ansible-playbook -vvv -i localhost, dev.yml --extra-vars "stack_name=$@"
