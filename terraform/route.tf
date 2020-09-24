resource "outscale_route_table" "public" {
  net_id = outscale_net.nomad.net_id
}

resource "outscale_route" "internet" {
  destination_ip_range = "0.0.0.0/0"
  gateway_id           = outscale_internet_service.nomad.internet_service_id
  route_table_id       = outscale_route_table.public.route_table_id
}

resource "outscale_route_table_link" "igw" {
  subnet_id      = outscale_subnet.adm.subnet_id
  route_table_id = outscale_route_table.public.id
}

