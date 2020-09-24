#!/usr/bin/env bash

set -e

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install consul

cp -f /tmp/consul.hcl /etc/consul.d/.

systemctl enable consul.service
