#!/bin/bash
# init steps for once the cluster is up and running

# create secret for pulling containers from private gcr registry
kubectl create secret docker-registry gcr-json-key --docker-server https://gcr.io --docker-username _json_key --docker-email=containers@rsa-servers.iam.gserviceaccount.com --docker-password="$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"

# give gcr secret to the default k8s service account
kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"gcr-json-key\"}]}"

# create a svc account and rolebinding for tiller and initialize helm
kubectl apply -f manifests/01-tiller-role.yaml
helm init --service-account tiller

# create a persistent volume claim (for keys) for openvpn and initialize it
kubectl apply -f manifests/02-openvpn-persistent-vol.yaml
helm install stable/openvpn --version 2.0.2 --set persistence.existingClaim=openvpn --set service.type=NodePort --set service.externalPort=8080

# install nginx ingress controller (including TCP pass through for VPN connectivity)
helm install stable/nginx-ingress --set rbac.create=true --set controller.service.type=NodePort --set controller.hostNetwork=true --set tcp.8080=default/`kubectl get deployment -l 'chart in (openvpn-2.0.2)' -o jsonpath="{.items[0].metadata.name}"`:8080
