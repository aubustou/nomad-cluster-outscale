provider "outscale" {
  access_key_id = var.access_key_id
  secret_key_id = var.secret_key_id
  region        = var.region
  endpoints {
    api = "https://api.${var.region}.outscale.com/api/v1"
  }
}

resource "outscale_keypair" "nomad" {
  keypair_name = "nomad-keypair"
  public_key   = file("id_rsa_4096.pub")
}

resource "outscale_vm" "nomad_server_1" {
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.nomad-server.id
  vm_type      = var.vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.nomad_server.id,
  outscale_security_group.default.id]
  user_data = data.cloudinit_config.nomad_server.rendered
  subnet_id = outscale_subnet.bastion.subnet_id
  tags {
    key   = "name"
    value = "nomad-server-1"
  }
  depends_on = [outscale_vm.consul_server_1]
}

resource "outscale_vm" "nomad_server" {
  count        = 2
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.nomad-server.id
  vm_type      = var.vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.default.id,
  outscale_security_group.nomad_server.id]
  user_data = data.cloudinit_config.nomad_server.rendered
  subnet_id = outscale_subnet.adm.subnet_id
  tags {
    key   = "name"
    value = "nomad-server-${count.index + 2}"
  }
  depends_on = [outscale_vm.consul_server_1]
}

resource "outscale_vm" "nomad-client" {
  count        = 6
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.nomad-client.id
  vm_type      = var.client_vm_type
  user_data    = data.cloudinit_config.nomad_server.rendered
  subnet_id    = outscale_subnet.adm.subnet_id
  security_group_ids = [outscale_security_group.ssh.id,
  outscale_security_group.default.id]
  tags {
    key   = "name"
    value = "nomad-client-${count.index + 1}"
  }
  depends_on = [outscale_vm.nomad_server_1]
}

resource "outscale_vm" "consul_server_1" {
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.consul-server.id
  vm_type      = var.vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.default.id,
  outscale_security_group.consul_server.id]
  subnet_id = outscale_subnet.bastion.subnet_id
  tags {
    key   = "name"
    value = "consul-server-1"
  }
}

resource "outscale_vm" "consul_server" {
  count        = 2
  keypair_name = outscale_keypair.nomad.keypair_name
  image_id     = data.outscale_image.consul-server.id
  vm_type      = var.vm_type
  security_group_ids = [outscale_security_group.ssh.id,
    outscale_security_group.default.id,
  outscale_security_group.consul_server.id]
  subnet_id = outscale_subnet.bastion.subnet_id
  user_data = data.cloudinit_config.nomad_server.rendered

  tags {
    key   = "name"
    value = "consul-server-${count.index + 2}"
  }
}
