data "cloudinit_config" "nomad_server" {
  gzip          = false
  base64_encode = true
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   echo retry_join = [\"${outscale_vm.consul_server_1.private_ip}\"] > /etc/consul.d/join.hcl
EOF
  }
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   systemctl restart consul
                   systemctl restart nomad
EOF
  }
}

data "cloudinit_config" "haproxy" {
  gzip          = false
  base64_encode = true
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   echo retry_join = [\"${outscale_vm.consul_server_1.private_ip}\"] > /etc/consul.d/join.hcl
EOF
  }
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   systemctl restart consul
                   /tmp/consul-template -template "/tmp/haproxy.cfg.ctmpl:/etc/haproxy/haproxy.cfg"
                   systemctl restart haproxy
EOF
  }
}

data "cloudinit_config" "haproxy-admin" {
  gzip          = false
  base64_encode = true
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   echo retry_join = [\"${outscale_vm.consul_server_1.private_ip}\"] > /etc/consul.d/join.hcl
EOF
  }
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   systemctl restart consul
                   /tmp/consul-template -template "/tmp/haproxy.cfg.ctmpl:/etc/haproxy/haproxy.cfg"
                   systemctl restart haproxy
EOF
  }
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
                   #! /bin/bash
                   sed -ie 's/CONSUL_SERVER/${outscale_vm.consul_server_1.private_ip}/' listeners.conf.admin
                   cp /tmp/listeners.conf.admin /etc/haproxy/listeners.conf
                   systemctl restart haproxy
EOF
  }
}
