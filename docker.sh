#!/bin/bash

set -x
echo -e "Installing docker on the host system ...\n"
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io -y 
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
if [[ $(docker --version | grep "Docker version") == " " ]]
then
    echo -e "Docker is not installed\n"
else
    echo -e "Docker is installed\n"
fi

echo -e "To run the docker container ls command you might neet to exit this shell and relogin again"
