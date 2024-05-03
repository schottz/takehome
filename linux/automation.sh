#!/bin/bash

IMAGE_NAME=mygoapp
docker build -t $IMAGE_NAME ../dockerize/
TAG=`date +"%s"`
docker tag mygoapp $IMAGE_NAME:$TAG
sed "s#MY_NEW_IMAGE#$IMAGE_NAME:$TAG#g" script.yaml > new-app.yaml
kubectl diff -f new-app.yaml