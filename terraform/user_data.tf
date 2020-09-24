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

