#!/bin/bash

ansible-playbook -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key $@
