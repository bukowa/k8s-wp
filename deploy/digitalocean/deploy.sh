#!/bin/bash
set -eux

NAMESPACE="webstack"

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add jetstack https://charts.jetstack.io

kubectl create namespace ${NAMESPACE} || true

helm install --namespace=${NAMESPACE} ingress-nginx ingress-nginx/ingress-nginx \
  --values=helm.ingress-nginx.yaml \
  --version=4.4.0

#helm install --namespace=${NAMESPACE} cert-manager jetstack/cert-manager \
#  --values=helm.cert-manager.yaml \
#  --version=v1.10.0 \
#  --wait
#
#kubectl apply --namespace=${NAMESPACE} -f certissuer.yaml
