#!/bin/bash

# run an ansible playbook against local vagrant machine
ansible-playbook -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key $@

# put the fetched kubeconfig in place
cp ansible/kubeconfig/127.0.0.1/etc/kubernetes/admin.conf ~/.kube/config
sed -i 's/10\.0\.2\.15/jessie/' ~/.kube/config

