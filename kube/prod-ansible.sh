#!/bin/bash

# run ansible playbook against brazen host
ansible-playbook -i "168.235.108.115," -u phro --private-key ~/.ssh/id_brazen $@ 
