# single_node_k8s_cluster
Single node kubernetes cluster script alongwith seperate docker script. Scripts are based on ubuntu right now. For multi-node cluster paste the tokens in the output to the other nodes.

## Introduction

A simple cluster configuration setup for kubernetes as well as docker.

## Purpose

Initalise the kubernetes cluster with ease so that it can be installed on the fly. Also a seperate docker setup file for ubuntu machines. The purpose is to ease the deployment of services on kubenetes.

## Deployments
Deployments are based on kubeadm and deployed on ubuntu.

## Security Reports
### Master
```
[INFO] 1 Master Node Security Configuration
[INFO] 1.1 Master Node Configuration Files
[PASS] 1.1.1 Ensure that the API server pod specification file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.2 Ensure that the API server pod specification file ownership is set to root:root (Scored)
[PASS] 1.1.3 Ensure that the controller manager pod specification file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.4 Ensure that the controller manager pod specification file ownership is set to root:root (Scored)
[PASS] 1.1.5 Ensure that the scheduler pod specification file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.6 Ensure that the scheduler pod specification file ownership is set to root:root (Scored)
[PASS] 1.1.7 Ensure that the etcd pod specification file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.8 Ensure that the etcd pod specification file ownership is set to root:root (Scored)
[WARN] 1.1.9 Ensure that the Container Network Interface file permissions are set to 644 or more restrictive (Not Scored)
[WARN] 1.1.10 Ensure that the Container Network Interface file ownership is set to root:root (Not Scored)
[PASS] 1.1.11 Ensure that the etcd data directory permissions are set to 700 or more restrictive (Scored)
[FAIL] 1.1.12 Ensure that the etcd data directory ownership is set to etcd:etcd (Scored)
[PASS] 1.1.13 Ensure that the admin.conf file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.14 Ensure that the admin.conf file ownership is set to root:root (Scored)
[PASS] 1.1.15 Ensure that the scheduler.conf file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.16 Ensure that the scheduler.conf file ownership is set to root:root (Scored)
[PASS] 1.1.17 Ensure that the controller-manager.conf file permissions are set to 644 or more restrictive (Scored)
[PASS] 1.1.18 Ensure that the controller-manager.conf file ownership is set to root:root (Scored)
[PASS] 1.1.19 Ensure that the Kubernetes PKI directory and file ownership is set to root:root (Scored)
[PASS] 1.1.20 Ensure that the Kubernetes PKI certificate file permissions are set to 644 or more restrictive (Not Scored)
[PASS] 1.1.21 Ensure that the Kubernetes PKI key file permissions are set to 600 (Not Scored)
[INFO] 1.2 API Server
[WARN] 1.2.1 Ensure that the --anonymous-auth argument is set to false (Not Scored)
[PASS] 1.2.2 Ensure that the --basic-auth-file argument is not set (Scored)
[PASS] 1.2.3 Ensure that the --token-auth-file parameter is not set (Scored)
[PASS] 1.2.4 Ensure that the --kubelet-https argument is set to true (Scored)
[PASS] 1.2.5 Ensure that the --kubelet-client-certificate and --kubelet-client-key arguments are set as appropriate (Scored)
[FAIL] 1.2.6 Ensure that the --kubelet-certificate-authority argument is set as appropriate (Scored)
[PASS] 1.2.7 Ensure that the --authorization-mode argument is not set to AlwaysAllow (Scored)
[PASS] 1.2.8 Ensure that the --authorization-mode argument includes Node (Scored)
[PASS] 1.2.9 Ensure that the --authorization-mode argument includes RBAC (Scored)
[WARN] 1.2.10 Ensure that the admission control plugin EventRateLimit is set (Not Scored)
[PASS] 1.2.11 Ensure that the admission control plugin AlwaysAdmit is not set (Scored)
[PASS] 1.2.12 Ensure that the admission control plugin AlwaysPullImages is set (Not Scored)
[WARN] 1.2.13 Ensure that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used (Not Scored)
[PASS] 1.2.14 Ensure that the admission control plugin ServiceAccount is set (Scored)
[PASS] 1.2.15 Ensure that the admission control plugin NamespaceLifecycle is set (Scored)
[FAIL] 1.2.16 Ensure that the admission control plugin PodSecurityPolicy is set (Scored)
[PASS] 1.2.17 Ensure that the admission control plugin NodeRestriction is set (Scored)
[PASS] 1.2.18 Ensure that the --insecure-bind-address argument is not set (Scored)
[PASS] 1.2.19 Ensure that the --insecure-port argument is set to 0 (Scored)
[PASS] 1.2.20 Ensure that the --secure-port argument is not set to 0 (Scored)
[PASS] 1.2.21 Ensure that the --profiling argument is set to false (Scored)
[PASS] 1.2.22 Ensure that the --audit-log-path argument is set (Scored)
[PASS] 1.2.23 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate (Scored)
[PASS] 1.2.24 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate (Scored)
[PASS] 1.2.25 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate (Scored)
[PASS] 1.2.26 Ensure that the --request-timeout argument is set as appropriate (Scored)
[PASS] 1.2.27 Ensure that the --service-account-lookup argument is set to true (Scored)
[PASS] 1.2.28 Ensure that the --service-account-key-file argument is set as appropriate (Scored)
[PASS] 1.2.29 Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate (Scored)
[PASS] 1.2.30 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Scored)
[PASS] 1.2.31 Ensure that the --client-ca-file argument is set as appropriate (Scored)
[PASS] 1.2.32 Ensure that the --etcd-cafile argument is set as appropriate (Scored)
[WARN] 1.2.33 Ensure that the --encryption-provider-config argument is set as appropriate (Not Scored)
[WARN] 1.2.34 Ensure that encryption providers are appropriately configured (Not Scored)
[WARN] 1.2.35 Ensure that the API Server only makes use of Strong Cryptographic Ciphers (Not Scored)
[INFO] 1.3 Controller Manager
[WARN] 1.3.1 Ensure that the --terminated-pod-gc-threshold argument is set as appropriate (Not Scored)
[PASS] 1.3.2 Ensure that the --profiling argument is set to false (Scored)
[PASS] 1.3.3 Ensure that the --use-service-account-credentials argument is set to true (Scored)
[PASS] 1.3.4 Ensure that the --service-account-private-key-file argument is set as appropriate (Scored)
[PASS] 1.3.5 Ensure that the --root-ca-file argument is set as appropriate (Scored)
[PASS] 1.3.6 Ensure that the RotateKubeletServerCertificate argument is set to true (Scored)
[PASS] 1.3.7 Ensure that the --bind-address argument is set to 127.0.0.1 (Scored)
[INFO] 1.4 Scheduler
[PASS] 1.4.1 Ensure that the --profiling argument is set to false (Scored)
[PASS] 1.4.2 Ensure that the --bind-address argument is set to 127.0.0.1 (Scored)

== Remediations ==
1.1.9 Run the below command (based on the file location on your system) on the master node.
For example,
chmod 644 <path/to/cni/files>

1.1.10 Run the below command (based on the file location on your system) on the master node.
For example,
chown root:root <path/to/cni/files>

1.1.12 On the etcd server node, get the etcd data directory, passed as an argument --data-dir,
from the below command:
ps -ef | grep etcd
Run the below command (based on the etcd data directory found above).
For example, chown etcd:etcd /var/lib/etcd

1.2.1 Edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
on the master node and set the below parameter.
--anonymous-auth=false

1.2.6 Follow the Kubernetes documentation and setup the TLS connection between
the apiserver and kubelets. Then, edit the API server pod specification file
/etc/kubernetes/manifests/kube-apiserver.yaml on the master node and set the
--kubelet-certificate-authority parameter to the path to the cert file for the certificate authority.
--kubelet-certificate-authority=<ca-string>

1.2.10 Follow the Kubernetes documentation and set the desired limits in a configuration file.
Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
and set the below parameters.
--enable-admission-plugins=...,EventRateLimit,...
--admission-control-config-file=<path/to/configuration/file>

1.2.13 Edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
on the master node and set the --enable-admission-plugins parameter to include
SecurityContextDeny, unless PodSecurityPolicy is already in place.
--enable-admission-plugins=...,SecurityContextDeny,...

1.2.16 Follow the documentation and create Pod Security Policy objects as per your environment.
Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
on the master node and set the --enable-admission-plugins parameter to a
value that includes PodSecurityPolicy:
--enable-admission-plugins=...,PodSecurityPolicy,...
Then restart the API Server.

1.2.33 Follow the Kubernetes documentation and configure a EncryptionConfig file.
Then, edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
on the master node and set the --encryption-provider-config parameter to the path of that file: --encryption-provider-config=</path/to/EncryptionConfig/File>

1.2.34 Follow the Kubernetes documentation and configure a EncryptionConfig file.
In this file, choose aescbc, kms or secretbox as the encryption provider.

1.2.35 Edit the API server pod specification file /etc/kubernetes/manifests/kube-apiserver.yaml
on the master node and set the below parameter.
--tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256

1.3.1 Edit the Controller Manager pod specification file /etc/kubernetes/manifests/kube-controller-manager.yaml
on the master node and set the --terminated-pod-gc-threshold to an appropriate threshold,
for example:
--terminated-pod-gc-threshold=10


== Summary ==
53 checks PASS
3 checks FAIL
9 checks WARN
0 checks INFO
```
### Worker Node
```
[INFO] 4 Worker Node Security Configuration
[INFO] 4.1 Worker Node Configuration Files
[PASS] 4.1.1 Ensure that the kubelet service file permissions are set to 644 or more restrictive (Scored)
[PASS] 4.1.2 Ensure that the kubelet service file ownership is set to root:root (Scored)
[FAIL] 4.1.3 Ensure that the proxy kubeconfig file permissions are set to 644 or more restrictive (Scored)
[FAIL] 4.1.4 Ensure that the proxy kubeconfig file ownership is set to root:root (Scored)
[PASS] 4.1.5 Ensure that the kubelet.conf file permissions are set to 644 or more restrictive (Scored)
[PASS] 4.1.6 Ensure that the kubelet.conf file ownership is set to root:root (Scored)
[PASS] 4.1.7 Ensure that the certificate authorities file permissions are set to 644 or more restrictive (Scored)
[PASS] 4.1.8 Ensure that the client certificate authorities file ownership is set to root:root (Scored)
[PASS] 4.1.9 Ensure that the kubelet configuration file has permissions set to 644 or more restrictive (Scored)
[PASS] 4.1.10 Ensure that the kubelet configuration file ownership is set to root:root (Scored)
[INFO] 4.2 Kubelet
[PASS] 4.2.1 Ensure that the anonymous-auth argument is set to false (Scored)
[PASS] 4.2.2 Ensure that the --authorization-mode argument is not set to AlwaysAllow (Scored)
[PASS] 4.2.3 Ensure that the --client-ca-file argument is set as appropriate (Scored)
[PASS] 4.2.4 Ensure that the --read-only-port argument is set to 0 (Scored)
[PASS] 4.2.5 Ensure that the --streaming-connection-idle-timeout argument is not set to 0 (Scored)
[PASS] 4.2.6 Ensure that the --protect-kernel-defaults argument is set to true (Scored)
[PASS] 4.2.7 Ensure that the --make-iptables-util-chains argument is set to true (Scored)
[PASS] 4.2.8 Ensure that the --hostname-override argument is not set (Not Scored)
[WARN] 4.2.9 Ensure that the --event-qps argument is set to 0 or a level which ensures appropriate event capture (Not Scored)
[PASS] 4.2.10 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate (Scored)
[PASS] 4.2.11 Ensure that the --rotate-certificates argument is not set to false (Scored)
[PASS] 4.2.12 Ensure that the RotateKubeletServerCertificate argument is set to true (Scored)
[PASS] 4.2.13 Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers (Not Scored)

== Remediations ==
4.1.3 Run the below command (based on the file location on your system) on the each worker node.
For example,
chmod 644 /etc/kubernetes/proxy.conf

4.1.4 Run the below command (based on the file location on your system) on the each worker node.
For example, chown root:root /etc/kubernetes/proxy.conf

4.2.9 If using a Kubelet config file, edit the file to set eventRecordQPS: to an appropriate level.
If using command line arguments, edit the kubelet service file
/etc/systemd/system/kubelet.service.d/10-kubeadm.conf on each worker node and
set the below parameter in KUBELET_SYSTEM_PODS_ARGS variable.
Based on your system, restart the kubelet service. For example:
systemctl daemon-reload
systemctl restart kubelet.service


== Summary ==
20 checks PASS
2 checks FAIL
1 checks WARN
0 checks INFO
```
Source of security tests [kube-bench](https://github.com/aquasecurity/kube-bench#running-on-openshift)
### How to contribute
Will be added soon

