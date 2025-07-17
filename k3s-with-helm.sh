#!/bin/bash

set -e

echo "==> Installing K3s with kubeconfig mode 644..."
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

echo "==> Waiting for K3s to initialize..."
sleep 10

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Persist the KUBECONFIG variable (optional)
if ! grep -q 'KUBECONFIG=/etc/rancher/k3s/k3s.yaml' ~/.bashrc; then
  echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
fi

echo "==> Verifying K3s installation..."
kubectl get nodes

echo "==> Downloading Helm installation script..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

echo "==> Setting permissions and running Helm installer..."
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

echo "==> Verifying Helm installation..."
helm version

echo "🎉 K3s and Helm installed successfully!"
