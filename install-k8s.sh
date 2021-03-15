#!/bin/bash

curl -s https://github.com/ZhangGaoxing/shell-script/raw/main/k8s-key.gpg | apt-key add -
echo "deb https://mirrors.tuna.tsinghua.edu.cn/kubernetes/apt kubernetes-xenial main" | \
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

cat > /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --image-repository registry.aliyuncs.com/google_containers