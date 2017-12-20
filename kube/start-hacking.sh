#!/bin/bash

# start and then reboot the vagrant vm (to make the grub config change take hold)
vagrant up
vagrant reload

# apply the ansible playbook
./dev-ansible.sh ansible/vagrant.yaml

# run postscript (enable kube router, image registry secrets, and ingress controllers)
./postscript.sh
