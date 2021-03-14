#!/bin/bash

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "deb [arch=arm64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian \
     $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
    
apt update
apt install -y docker-ce

usermod -aG docker $USER

systemctl daemon-reload
systemctl restart docker
