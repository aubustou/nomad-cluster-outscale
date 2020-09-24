#!/usr/bin/env bash

set -e

cp -f /tmp/consul.hcl /etc/consul.d/.

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker.service
