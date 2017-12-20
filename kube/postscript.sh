#!/bin/bash

cp ansible/kubeconfig/127.0.0.1/etc/kubernetes/admin.conf ~/.kube/config
sed -i 's/10\.0\.2\.15/jessie/' ~/.kube/config

# enable full features of kube-router networking
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

# enable calico
#kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml

#enable flannel
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# allow pods to be scheduled on the master
kubectl taint nodes --all node-role.kubernetes.io/master-

# create secret for pulling containers from gcr
kubectl create secret docker-registry gcr-json-key --docker-server https://gcr.io --docker-username _json_key --docker-email=containers@rsa-servers.iam.gserviceaccount.com --docker-password="$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"

# give gcr secret to the default k8s service account
kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"gcr-json-key\"}]}"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml
kubectl apply -f manifests/nginx-deployment-with-rbac.yaml
