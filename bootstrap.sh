#!/bin/bash
# Install docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu

sudo docker pull ak11in/wipro:lts
sudo docker run -d -p 3000:3000 --name wipro ak11in/wipro:lts