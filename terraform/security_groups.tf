resource "outscale_security_group" "ssh" {
  description         = "ssh"
  security_group_name = "nomad-ssh"
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_security_group_rule" "ssh" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ssh.id

  from_port_range = "22"
  to_port_range   = "22"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group" "nomad_server" {
  description         = "server"
  security_group_name = "nomad-server"
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_security_group_rule" "api" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.nomad_server.id

  from_port_range = "4646"
  to_port_range   = "4646"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group_rule" "rpc_tcp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.nomad_server.id

  from_port_range = "4648"
  to_port_range   = "4648"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "rpc_udp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.nomad_server.id

  from_port_range = "4648"
  to_port_range   = "4648"

  ip_protocol = "udp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group_rule" "nomad_client" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.nomad_server.id

  from_port_range = "4647"
  to_port_range   = "4647"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group" "consul_server" {
  description         = "server"
  security_group_name = "consul-server"
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_security_group_rule" "consul_client" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8500"
  to_port_range   = "8500"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "rpc" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8300"
  to_port_range   = "8300"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "serf_lan_tcp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8301"
  to_port_range   = "8301"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "serf_lan_udp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8301"
  to_port_range   = "8301"

  ip_protocol = "udp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "serf_wan_tcp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8302"
  to_port_range   = "8302"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "serf_wan_udp" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8302"
  to_port_range   = "8302"

  ip_protocol = "udp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "dns" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.consul_server.id

  from_port_range = "8600"
  to_port_range   = "8600"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
