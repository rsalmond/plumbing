#!/bin/bash

# start and then reboot the vagrant vm (to make the grub config change take hold)
vagrant up && sleep 3

./dev-ansible.sh ansible/cgroup.yaml

# need to reboot after changing cgroups
vagrant reload && sleep 3

# install all the requirements, repos, etc
./dev-ansible.sh ansible/base.yaml

# initialize kubernetes and download kubeconfig file
./dev-ansible.sh ansible/kube-init.yaml

# put the fetched kubeconfig in place
cp ansible/kubeconfig/kubernetes/etc/kubernetes/admin.conf ~/.kube/config
sed -i 's/10\.0\.2\.15/kubernetes/' ~/.kube/config

# enable kube router with firewall and proxy
#kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml
# enable kube router with firewall
#kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml
# enable kube router with no proxy and no firewall
kubectl apply -f manifests/00-kubeadm-kuberouter.yaml

# allow pods to be scheduled on the master
kubectl taint nodes --all node-role.kubernetes.io/master-
