#!/bin/bash
set -euo pipefail
echo "Installing ArgoCD..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
kubectl create namespace argocd || true
helm install argocd argo/argo-cd \
  --namespace argocd \
  --version 7.7.12 \
  --set configs.params."application\.namespaces"="*" \
  --set server.service.type=ClusterIP \
  --wait
echo "ArgoCD installed."
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo
