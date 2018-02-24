#!/bin/bash

# run an ansible playbook against local vagrant machine
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "kubernetes," -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key -e 'ansible_python_interpreter=/usr/bin/python3' $@ 
