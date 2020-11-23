resource "outscale_internet_service" "nomad" {
  depends_on = [outscale_net.nomad]
}

resource "outscale_net" "nomad" {
  ip_range = "10.0.0.0/16"
  tags {
    key   = "name"
    value = "nomad-network"
  }
}

resource "outscale_internet_service_link" "nomad" {
  internet_service_id = outscale_internet_service.nomad.internet_service_id
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_subnet" "bastion" {
  subregion_name = "${var.region}a"
  ip_range       = "10.0.0.0/24"
  net_id         = outscale_net.nomad.net_id
  tags {
    key   = "name"
    value = "nomad-bastion"
  }
}

resource "outscale_subnet" "adm" {
  subregion_name = "${var.region}a"
  ip_range       = "10.0.1.0/24"
  net_id         = outscale_net.nomad.net_id
  tags {
    key   = "name"
    value = "nomad-adm"
  }
}

resource "outscale_nat_service" "adm" {
  depends_on   = [outscale_internet_service.nomad]
  subnet_id    = outscale_subnet.bastion.subnet_id
  public_ip_id = outscale_public_ip.nat.public_ip_id
}
