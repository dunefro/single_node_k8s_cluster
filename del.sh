#!/bin/bash

sudo kubeadm reset --force

sudo systemctl restart docker

sudo iptables -F

sudo iptables -tnat -F
