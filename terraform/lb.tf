resource "outscale_vm" "admin_lb" {
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.haproxy.id
  vm_type      = var.lb_vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.consul_server.id,
    outscale_security_group.default.id,
  outscale_security_group.admin_lb.id]
  subnet_id = outscale_subnet.bastion.subnet_id
  user_data = data.cloudinit_config.haproxy.rendered

  tags {
    key   = "name"
    value = "haproxy"
  }
  depends_on = [outscale_vm.consul_server_1]
}

resource "outscale_vm" "client_lb" {
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.haproxy.id
  vm_type      = var.lb_vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.consul_server.id,
    outscale_security_group.default.id,
  outscale_security_group.client_lb.id]
  subnet_id = outscale_subnet.bastion.subnet_id
  user_data = data.cloudinit_config.haproxy.rendered

  tags {
    key   = "name"
    value = "client-haproxy"
  }
  depends_on = [outscale_vm.consul_server_1]
}
