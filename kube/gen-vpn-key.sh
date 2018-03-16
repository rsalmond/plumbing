#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <CLIENT_KEY_NAME> <HOSTNAME>"
	exit
fi

KEY_NAME=$1;shift
SERVICE_IP=$1

NAMESPACE=$(kubectl get pods --all-namespaces -l type=openvpn -o jsonpath='{.items[0].metadata.namespace}')
POD_NAME=$(kubectl get pods -n $NAMESPACE -l type=openvpn -o jsonpath='{.items[0].metadata.name}')
SERVICE_NAME=$(kubectl get service -n $NAMESPACE -l type=openvpn  -o jsonpath='{.items[0].metadata.name}')
kubectl -n $NAMESPACE exec -it $POD_NAME /etc/openvpn/setup/newClientCert.sh $KEY_NAME $SERVICE_IP
kubectl -n $NAMESPACE exec -it $POD_NAME cat /etc/openvpn/certs/pki/$KEY_NAME.ovpn > $KEY_NAME.ovpn
