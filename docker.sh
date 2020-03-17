#!/bin/bash

set -x
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io -y 
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
if [[ $(docker --version | grep "Docker version") == " " ]]
then
    echo -e "Docker is not installed properly\n"
else
    echo -e "Docker is installed\n"
fi
echo -e "\nTo run the docker container ls command you might neet to exit this shell and relogin again"
