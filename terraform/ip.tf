resource "outscale_public_ip" "public" {
}

resource "outscale_public_ip_link" "nomad_server" {
  vm_id     = outscale_vm.nomad_server_1.vm_id
  public_ip = outscale_public_ip.public.public_ip
}

resource "outscale_public_ip" "consul" {
}

resource "outscale_public_ip_link" "consul_server" {
  vm_id     = outscale_vm.consul_server_1.vm_id
  public_ip = outscale_public_ip.consul.public_ip
}

resource "outscale_public_ip" "nat" {
}
