provider "consul" {
  address = "${outscale_vm.consul_server_1.public_ip}:8500"
}

resource "consul_keys" "haproxy" {
  token = "abcd"

  key {
    path  = "service/haproxy/maxconn"
    value = "65535"
  }
  key {
    path  = "service/haproxy/mode"
    value = "http"
  }
  key {
    path  = "service/haproxy/timeouts/client"
    value = "30"
  }
  key {
    path  = "service/haproxy/timeouts/server"
    value = "30"
  }
  key {
    path  = "service/haproxy/timeouts/connect"
    value = "30"
  }
}
