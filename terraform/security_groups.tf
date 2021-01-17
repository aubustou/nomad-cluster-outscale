# SSH
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

resource "outscale_security_group" "client_lb" {
  description         = "client-lb"
  security_group_name = "client-lb"
  net_id              = outscale_net.nomad.net_id
}
resource "outscale_security_group_rule" "http" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.client_lb.id

  from_port_range = "80"
  to_port_range   = "80"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "client_haproxy_stats" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.client_lb.id

  from_port_range = "1936"
  to_port_range   = "1936"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "fabio_stats" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.client_lb.id

  # Fabio stats
  from_port_range = "9998"
  to_port_range   = "9998"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "faas_monitoring" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.client_lb.id

  from_port_range = "3000"
  to_port_range   = "3000"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group" "admin_lb" {
  description         = "admin_lb"
  security_group_name = "nomad-admin_lb"
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_security_group_rule" "consul" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.admin_lb.id
  from_port_range   = "8500"
  to_port_range     = "8500"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "nomad" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.admin_lb.id
  # Nomad
  from_port_range = "4646"
  to_port_range   = "4646"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}
resource "outscale_security_group_rule" "haproxy_stats" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.admin_lb.id
  from_port_range   = "1936"
  to_port_range     = "1936"

  ip_protocol = "tcp"
  ip_range    = "0.0.0.0/0"
}

resource "outscale_security_group" "default" {
  description         = "default-sg"
  security_group_name = "default-sg"
  net_id              = outscale_net.nomad.net_id
}

resource "outscale_security_group_rule" "default_inbound" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.default.id
  rules {
    ip_protocol = "-1"
    security_groups_members {
      account_id        = var.account_id
      security_group_id = outscale_security_group.default.id
    }
  }
}
