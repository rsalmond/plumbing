#!/bin/bash

# start and then reboot the vagrant vm (to make the grub config change take hold)
vagrant up

./dev-ansible.sh ansible/cgroup.yaml

# need to reboot after changing cgroups
vagrant reload

# install all the requirements, repos, etc
./dev-ansible.sh ansible/kubernetes-base.yaml

# initialize kubernetes and download kubeconfig file
./dev-ansible.sh ansible/kube-init.yaml

# put the fetched kubeconfig in place
cp ansible/kubeconfig/127.0.0.1/etc/kubernetes/admin.conf ~/.kube/config
sed -i 's/10\.0\.2\.15/kubernetes/' ~/.kube/config

# enable full features of kube-router networking
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

# allow pods to be scheduled on the master
kubectl taint nodes --all node-role.kubernetes.io/master-
