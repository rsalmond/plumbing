#!/bin/bash

# run an ansible playbook against local vagrant machine
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key $@
