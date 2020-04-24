#!/bin/bash

#istioctl manifest generate \
istioctl manifest apply \
  --set values.gateways.istio-ingressgateway.sds.enabled=true \
  --set values.global.k8sIngress.enabled=true \
  --set values.global.k8sIngress.enableHttps=true \
  --set values.pilot.resources.requests.memory=512Mi 
#  --log_output_level all:debug
#  --set values.global.k8sIngress.gatewayName=ingressgateway

kubectl -n istio-system \
  patch gateway istio-autogenerated-k8s-ingress --type=json \
  -p='[{"op": "replace", "path": "/spec/servers/1/tls", "value": {"credentialName": "ingress-cert", "mode": "SIMPLE", "privateKey": "sds", "serverCertificate": "sds"}}]'

kubectl -n istio-system \
  patch gateway istio-autogenerated-k8s-ingress --type=json \
  -p='[{"op": "replace", "path": "/spec/servers/0/tls", "value": {"httpsRedirect": true}}]'

kubectl create ns cert-manager

# https://github.com/jetstack/cert-manager/releases/download/v0.14.0/cert-manager.yaml
kubectl apply -f cert-manager.yaml