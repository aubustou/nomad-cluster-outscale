#!/usr/bin/env bash

set -e

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install nomad

cp /tmp/nomad-server.service /etc/systemd/system/nomad-server.service
systemctl enable nomad-server.service
