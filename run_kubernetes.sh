#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=desherbojhaa/udacity-predict

# Step 2
# Run the Docker Hub container with kubernetes
docker login
kubectl create deployment udacity-predict --image=$dockerpath:latest


# Step 3:
# List kubernetes pods
kubectl get deployments

# Step 4:
# Forward the container port to a host
kubectl port-forward deployment/udacity-predict 8080:80
