#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg > Docker.key
apt-key --keyring /etc/apt/trusted.gpg.d/Docker.gpg add Docker.key
rm Docker.key
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=s390x] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
apt-get update
DOCKER_VERSION=18.06.1
apt-get --assume-yes install docker-ce=${DOCKER_VERSION}~ce~3-0~ubuntu
