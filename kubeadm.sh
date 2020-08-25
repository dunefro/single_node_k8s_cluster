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
    echo -e "\n      --------------> Docker is installed...\n"
    echo $(docker --version)
fi

sudo systemctl start docker > /dev/null 2>&1
sudo systemctl enable docker > /dev/null 2>&1
sudo usermod -aG docker $USER > /dev/null 2>&1

call_break

echo -e "\nStep 2 --------------> Setting up Kubernetes Now...\n"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add > /dev/null 2>&1
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /dev/null 2>&1
echo -e "\n      --------------> Installing Kubeadm ...\n"
sudo apt install kubeadm -y > /dev/null 2>&1
kubeadm version -o json
echo -e "\n      --------------> Disabling swap Memory...\n"
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
echo -e "\n      --------------> Setting up Hostname: $host_name\n"

cat > /tmp/config.yaml <<EOF
apiServer:
  extraArgs:
    authorization-mode: Node,RBAC
    enable-admission-plugins: "NodeRestriction,AlwaysPullImages"
    audit-log-path: /var/log/apiserver/audit.log
    audit-log-maxage: "30"
    audit-log-maxbackup: "10"
    audit-log-maxsize: "2048"
    profiling: "false"
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta2
certificatesDir: /etc/kubernetes/pki
clusterName: kubernetes
controllerManager:
  extraArgs:
    profiling: "false"
    feature-gates: "RotateKubeletServerCertificate=true"
dns:
  type: CoreDNS
etcd:
  local:
    dataDir: /var/lib/etcd
imageRepository: k8s.gcr.io
kind: ClusterConfiguration
kubernetesVersion: v1.18.8
networking:
  dnsDomain: cluster.local
  podSubnet: 10.244.0.0/16
  serviceSubnet: 10.96.0.0/12
scheduler:
  extraArgs:
    profiling: "false"
EOF
sudo hostnamectl set-hostname $host_name > /dev/null 2>&1

call_break

echo -e "\nStep 3 --------------> Initializing the kubernetes cluster... \n"
sudo kubeadm init --config=/tmp/config.yaml > /dev/null 2>&1

call_break

echo -e "\nStep 4 --------------> Completing the installtion process...\n"
mkdir -p $HOME/.kube > /dev/null 2>&1
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config > /dev/null 2>&1
sudo chown $(id -u):$(id -g) $HOME/.kube/config > /dev/null 2>&1
# echo -e "\n"
# echo -e "Tainting nodes...\n"
# kubectl taint nodes --all node-role.kubernetes.io/master-

echo -e "\n      --------------> Adding Autocomplete feature for kubectl like commands" 
echo "source <(kubectl completion bash)" >> ~/.bashrc

call_break

echo -e "\nStep 5 --------------> Applying kubelet secutiry patches ...\n"
echo 'KUBELET_KUBEADM_ARGS="--cgroup-driver=cgroupfs --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2 --resolv-conf=/run/systemd/resolve/resolv.conf --tls-cert-file=/var/lib/kubelet/pki/kubelet.crt --tls-private-key-file=/var/lib/kubelet/pki/kubelet.key --feature-gates=RotateKubeletServerCertificate=true --protect-kernel-defaults=true --tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256"' | sudo tee -a /var/lib/kubelet/kubeadm-flags.env >/dev/null
sudo systemctl daemon-reload > /dev/null 2>&1
sudo systemctl restart kubelet > /dev/null 2>&1

call_break

echo -e "\nStep 6 --------------> Completing the process ...\n"
echo -e "\nStep 6 (A) --------------> Labeling master...\n"
kubectl label node $host_name type=master > /dev/null 2>&1
echo -e "\nStep 6 (B) --------------> Deploying flannel ...\n"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml > /dev/null 2>&1

sleep 45

call_break

echo -e "\nStep 7 --------------> Deploying latest Helm package ...\n"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > /dev/null 2>&1
chmod 700 get_helm.sh > /dev/null 2>&1
./get_helm.sh
echo 'source <(helm completion bash)' >> ~/.bashrc
rm -rf ./get_helm.sh
helm version

call_break

echo -e "\nSetup Complete\n"
