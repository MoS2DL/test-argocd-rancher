#!/user/bin/env bash


kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update

