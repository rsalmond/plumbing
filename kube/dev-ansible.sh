#!/bin/bash

# run an ansible playbook against local vagrant machine
ansible-playbook -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key $@
