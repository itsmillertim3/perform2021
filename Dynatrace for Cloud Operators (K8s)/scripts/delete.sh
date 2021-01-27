#!/bin/sh

echo "Deleting easyTravel"
kubectl delete -f easytravel-pluginservice-deployment.yaml
kubectl delete -f easytravel-backend-deployment.yaml
kubectl delete -f easytravel-frontend-deployment.yaml
kubectl delete -f easytravel-mongodb-deployment.yaml
kubectl delete -f easytravel-mongodb-service.yaml

