#!/bin/bash

# create secret for pulling containers from gcr
kubectl create secret docker-registry gcr-json-key --docker-server https://gcr.io --docker-username _json_key --docker-email=containers@rsa-servers.iam.gserviceaccount.com --docker-password="$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"

# give gcr secret to the default k8s service account
kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"gcr-json-key\"}]}"

# install nginx ingress controller https://github.com/kubernetes/ingress-nginx/blob/master/deploy/README.md
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml

# install modified nginx pod with hostnetworking enabled (so we can listen on 80/443)
kubectl apply -f manifests/nginx-deployment-with-rbac.yaml

# give svc account cluster-admin so helm will work
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
