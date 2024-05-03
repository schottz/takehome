#!/bin/bash

kubectl create ns takehome --dry-run=client -o yaml > namespace.yaml
kubectl create deployment go-app -n takehome --image=schottz/go_image --dry-run=client -o yaml > go-deployment.yaml

# Added Liveness probe, Readiness probe, Prestop hook and Init Container following the Kubernetes Documentation

kubectl -n takehome expose deployment/go-app --name=go-service --port 8080 --dry-run=client -o yaml > service.yaml

kuebctl apply -f ./

# Testing

minikube service go-service -n takehome 