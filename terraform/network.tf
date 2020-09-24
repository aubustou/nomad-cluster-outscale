resource "outscale_internet_service" "nomad" {
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

resource "outscale_subnet" "adm" {
  subregion_name = "${var.region}a"
  ip_range       = "10.0.0.0/24"
  net_id         = outscale_net.nomad.net_id
  tags {
    key   = "name"
    value = "nomad-adm"
  }
}
