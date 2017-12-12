#!/bin/bash

# remove old host key
ssh-keygen -f "/home/phro/.ssh/known_hosts" -R [127.0.0.1]:2222

# install ansible requirements
ansible vagrant -vvvv -u ubuntu --private-key .vagrant/machines/default/virtualbox/private_key --sudo -m raw -a "apt install python-minimal python-simplejson -y"

# run the kubernetes setup playbook
ansible-playbook -vvvv -u vagrant --private-key .vagrant/machines/default/virtualbox/private_key ansible/kubenode.yaml

# the playbook will export kubeconfig file from the VM, copy it over
cp ansible/kubeconfig/127.0.0.1/etc/kubernetes/admin.conf ~/.kube/config

# fix vagrant hostame
sed -i s/10\\.0\\.2\\.15/vagrant-k8s/ ~/.kube/config
