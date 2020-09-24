#!/usr/bin/env bash

set -e

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install -y nomad consul

cp -f /tmp/nomad.hcl /etc/nomad.d/.

systemctl enable consul.service
systemctl enable nomad.service
