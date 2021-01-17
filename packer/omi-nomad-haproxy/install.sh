#!/usr/bin/env bash

set -e

yum install --assumeyes epel-release
yum install --assumeyes unzip wget yum-utils vim gcc pcre-static pcre-devel openssl-devel systemd-devel inotify-tools

yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install --assumeyes consul
mv /tmp/consul-interface.hcl /etc/consul.d/interface.hcl
systemctl enable consul


# Install Consul-template
wget https://releases.hashicorp.com/consul-template/0.25.1/consul-template_0.25.1_linux_amd64.zip -O /tmp/consul-template.zip && unzip /tmp/consul-template.zip -d /tmp/

# Install Haproxy
wget https://www.haproxy.org/download/2.2/src/haproxy-2.2.5.tar.gz -O /tmp/haproxy.tar.gz
tar xzvf /tmp/haproxy.tar.gz -C /tmp/
cd /tmp/haproxy-2.2.5/
make TARGET=linux-glibc USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_CRYPT_H=1 USE_LIBCRYPT=1 USE_SYSTEMD=1
make install
mkdir -p /etc/haproxy
mkdir -p /var/lib/haproxy
touch /var/lib/haproxy/stats
ln -s /usr/local/sbin/haproxy /usr/bin/haproxy
cd /tmp/haproxy-2.2.5/contrib/systemd && make && cp haproxy.service /etc/systemd/system/. && cd /tmp/
systemctl daemon-reload
useradd -r haproxy
systemctl enable haproxy.service

# Install inotifywait service
chmod +x /tmp/inotifywait_haproxy.sh
cp /tmp/inotifywait_haproxy.sh /usr/local/bin/inotifywait_haproxy.sh
cp /tmp/inotifywait_haproxy.service /etc/systemd/system/.
systemctl enable inotifywait_haproxy.service
