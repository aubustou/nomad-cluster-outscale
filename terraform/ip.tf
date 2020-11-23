resource "outscale_public_ip" "public" {
}

resource "outscale_public_ip_link" "client_lb" {
  vm_id     = outscale_vm.client_lb.vm_id
  public_ip = outscale_public_ip.public.public_ip
}

resource "outscale_public_ip" "nat" {
}

resource "outscale_public_ip" "admin_lb" {
}

resource "outscale_public_ip_link" "admin_lb" {
  vm_id     = outscale_vm.admin_lb.vm_id
  public_ip = outscale_public_ip.admin_lb.public_ip
}
