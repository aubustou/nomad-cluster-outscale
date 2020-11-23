data "outscale_image" "nomad-server" {
  filter {
    name   = "image_names"
    values = ["Nomad-Server-Packer"]
  }
}

data "outscale_image" "nomad-client" {
  filter {
    name   = "image_names"
    values = ["Nomad-Client-Packer"]
  }
}

data "outscale_image" "consul-server" {
  filter {
    name   = "image_names"
    values = ["Consul-Server-Packer"]
  }
}

data "outscale_image" "haproxy" {
  filter {
    name   = "image_names"
    values = ["Consul-Haproxy-Packer"]
  }
}
