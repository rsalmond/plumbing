#!/bin/bash

# start and then reboot the vagrant vm (to make the grub config change take hold)
vagrant up
vagrant reload

# install all the requirements, repos, etc
./dev-ansible.sh ansible/vagrant.yaml

# initialize kubernetes and download kubeconfig file
./dev-ansible.sh ansible/vagrant-kube-init.yaml

# put the fetched kubeconfig in place
cp ansible/kubeconfig/127.0.0.1/etc/kubernetes/admin.conf ~/.kube/config
sed -i 's/10\.0\.2\.15/jessie/' ~/.kube/config

# run postscript (enable kube router, image registry secrets, and ingress controllers)
./postscript.sh
