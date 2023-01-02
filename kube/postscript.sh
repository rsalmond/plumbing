#!/bin/bash
# init steps for once the cluster is up and running

# create secret for pulling containers from private gcr registry
kubectl create secret docker-registry gcr-json-key --docker-server https://gcr.io --docker-username _json_key --docker-email=containers@rsa-servers.iam.gserviceaccount.com --docker-password="$(cat ~/.ssh/rsa-servers-bdeedbfb9414.json)"

# give gcr secret to the default k8s service account
kubectl patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"gcr-json-key\"}]}"

kubectl create namespace istio-system

./istioctl install --skip-confirmation -f manifestsv3/istio-1.16.1-modified-profile.yaml

helm install certman -f helm-values/cert-manager-prod.yaml jetstack/cert-manager
kubectl apply -f manifestsv3/cert-issuer-prod.yaml

kubectl apply -f manifestsv3/gateway.yaml
kubectl apply -f manifestsv3/prod-cert-ingress.yaml

kubectl apply -f manifestsv3/blog.yaml
