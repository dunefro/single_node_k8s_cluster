#!/bin/bash

echo -e "Deleting the node"

sudo kubeadm reset --force

echo -e "\n Restarting the docker daemon"

sudo systemctl restart docker

echo -e "\n Flushing the iptable rules"

sudo iptables -F

sudo iptables -tnat -F

sudo rm -rf /etc/kubernetes

sudo ip link delete cni0
