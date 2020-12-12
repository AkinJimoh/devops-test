#!/bin/bash
# Install docker
 apt-get update
 apt-get install -y apt-transport-https ca-certificates curl software-properties-common
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
 add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 apt-get update
 apt-get install awscli -y
 apt-get install -y docker.io
 usermod -aG docker ubuntu

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 458909167390.dkr.ecr.eu-west-2.amazonaws.com
docker run -d -p 3000:3000 --name wipro 458909167390.dkr.ecr.eu-west-2.amazonaws.com/wipro-p1:lts