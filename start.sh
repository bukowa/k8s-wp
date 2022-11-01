#!/bin/bash
set -eux

mkdir -p ./data/ || true

kind create cluster --config=./config.yaml

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx/ || true
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/ || true

helm install ingress ingress-nginx/ingress-nginx \
  --values=ingress-nginx.values.deploy.yaml \
  --version=4.3.0

helm install --set args={--kubelet-insecure-tls} metrics-server metrics-server/metrics-server --namespace kube-system \
  --version=3.8.2
