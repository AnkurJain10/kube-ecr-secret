#!/bin/bash

export AWS_PROFILE=aws-ci
export AWS_ACCOUNT=<AWS_ACCOUNT_NUMBER>
export AWS_REGION=us-east-1
export DOCKER_REGISTRY_SERVER=https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
export DOCKER_USER=AWS
export DOCKER_PASSWORD=`aws ecr get-login --region ${AWS_REGION} --registry-ids ${AWS_ACCOUNT} | cut -d' ' -f6`
echo $DOCKER_PASSWORD
kubectl delete secret aws-registry || true
kubectl create secret docker-registry aws-registry \
--docker-server=$DOCKER_REGISTRY_SERVER \
--docker-username=$DOCKER_USER \
--docker-password=$DOCKER_PASSWORD \
--docker-email=no@email.local
