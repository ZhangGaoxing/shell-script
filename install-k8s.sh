#!/bin/bash

curl -s https:/raw.githubusercontent.com/ZhangGaoxing/shell-script/main/k8s-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | \
    sudo tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install kubeadm kubectl kubelet

# cgroup limited
sed -i '$ s/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 swapaccount=1/' /boot/cmdline.txt

# disable swap
dphys-swapfile swapoff
dphys-swapfile uninstall
apt purge dphys-swapfile

# enable routing
cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_forward=1
EOF