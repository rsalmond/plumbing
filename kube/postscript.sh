#!/bin/bash

# enable full features of kube-router networking
#kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

# allow pods to be scheduled on the master
#kubectl taint nodes --all node-role.kubernetes.io/master-

# create secret for pulling containers from gcr
echo "$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"
kubectl create secret docker-registry gcr-json-key --docker-server https://gcr.io --docker-username _json_key --docker-email=containers@rsa-servers.iam.gserviceaccount.com --docker-password="$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"

# give gcr secret to the default k8s service account
#kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"gcr-json-key\"}]}"
