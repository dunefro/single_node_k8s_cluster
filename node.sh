#!/bin/bash

call_break() {
  echo -e "\n"
  column_length=$(($(tput cols)))
  mystring=$(printf "%${column_length}s")
  echo ${mystring// /#}
  echo -e "\n"
}

while [ -n "$1" ]
do
    key=$1
    case $key in

    -h|--hostname)
        shift;
        MASTER_HOSTNAME=$1;
        ;;
    *)
        shift;
        ;;
    esac
done


echo -e "Step 1 --------------> Installation of docker on the host system\n"
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get remove docker docker-engine docker.io -y  > /dev/null 2>&1
sudo apt install docker.io -y > /dev/null 2>&1
if [[ $(docker --version | grep "Docker version") == " " ]]
then
    echo -e "Docker is not installed\n"
    exit 1
else
    echo -e "Step 1 (A) --------------> Docker is installed...\n"
    echo $(docker --version)
fi

sudo systemctl start docker > /dev/null 2>&1
sudo systemctl enable docker > /dev/null 2>&1
sudo usermod -aG docker $USER > /dev/null 2>&1

call_break

echo -e "\nStep 2 --------------> Setting up Kubernetes Now...\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add > /dev/null 2>&1
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /dev/null 2>&1
echo -e "\nStep 2 (A) --------------> Installing Kubeadm ...\n"
sudo apt install kubeadm -y > /dev/null 2>&1
kubeadm version -o json
echo -e "\nStep 2 (B) --------------> Disabling swap Memory...\n"
sudo swapoff -a

if [ -z $MASTER_HOSTNAME ]
then
    host_name=$HOSTNAME
    echo -e "DO YOU WANT TO CONTINUE WITH THE HOSTNAME: $HOSTNAME ? [Type yes/no]"
    read response
    if [[ $response == "no" ]]
    then
        echo -e "Enter the new hostname : "
        read host_name
    fi
else
    host_name=$MASTER_HOSTNAME
fi
echo -e "\nStep 2 (C) --------------> Setting up Hostname: $host_name\n"