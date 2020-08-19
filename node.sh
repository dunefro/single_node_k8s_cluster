#!/bin/bash

echo -e "----------> Step 1: Installation of docker on the host system ...\n"
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

echo -e "----------> Step 2: Installing Kubernetes Now...\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
echo -e "----------> Step 2: (A) Installing Kubeadm ...\n"
sudo apt install kubeadm -y
kubeadm version -o json
echo -e "----------> Step 2: (B) Disabling swap Memory...\n"
sudo swapoff -a

echo "Applying kubelet secutiry patches ...\n"
echo 'KUBELET_KUBEADM_ARGS="--cgroup-driver=cgroupfs --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2 --resolv-conf=/run/systemd/resolve/resolv.conf --tls-cert-file=/var/lib/kubelet/pki/kubelet.crt --tls-private-key-file=/var/lib/kubelet/pki/kubelet.key --feature-gates=RotateKubeletServerCertificate=true --protect-kernel-defaults=true --tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256"' | sudo tee -a /var/lib/kubelet/kubeadm-flags.env >/dev/null
sudo systemctl daemon-reload
sudo systemctl restart kubelet

host_name=$HOSTNAME
echo -e "DO YOU WANT TO CONTINUE WITH THE HOSTNAME: $HOSTNAME ? [Type yes/no]"
read response
if [[ $response == "no" ]]
    then
    echo -e "Enter the new hostname : "
    read host_name
    sudo hostnamectl set-hostname $host_name
fi

echo -e "----------> Step 3: Deploying latest Helm package manager...\n"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
echo -e "Deployed Helm...\n"
echo 'source <(helm completion bash)' >> ~/.bashrc
rm -rf ./get_helm.sh
helm version
