#!/bin/bash

echo -e "Installation of docker on the host system ...\n"
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
    echo -e "Docker is installed...\n"
fi

echo -e "Installing Kubernetes Now...\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
echo -e "Installing Kubeadm ...\n"
sudo apt install kubeadm -y
kubeadm version -o json
echo -e "Disabling swap Memory...\n"
sudo swapoff -a

host_name=$HOSTNAME
echo -e "DO YOU WANT TO CONTINUE WITH THE HOSTNAME: $HOSTNAME ? [Type yes/no]"
read response
if [[ $response == "no" ]]
    then
    echo -e "Enter the new hostname : "
    read host_name
    sudo hostnamectl set-hostname $host_name
fi

echo -e "Kubeadm init ... \n"
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo -e "Completing the installtion process...\n"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo -e "\n"
echo -e "Tainting nodes...\n"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo -e "Labeling master...\n"
kubectl label node $host_name type=master
echo -e "\n"
echo -e "Deploying flannel ...\n"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

sleep 45
echo -e "Kubernetes is deployed\n\n"
echo -e "Deploying latest Helm package manager...\n"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
echo -e "Deployed Helm...\n"
rm -rf ./get_helm.sh
helm version
echo -e '\n'
echo -e '
'
echo -e '
'
echo -e '
'
