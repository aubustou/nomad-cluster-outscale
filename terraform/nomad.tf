provider "nomad" {
  address = "http://${outscale_vm.nomad_server_1.public_ip}:4646"
  region = "global"
}

#resource "nomad_job" "mock_app" {
#  depends_on = [outscale_vm.nomad_server_1]
#  jobspec = file("nomad/jobspec.hcl")
#}
#
#resource "nomad_job" "mock_service" {
#  depends_on = [outscale_vm.nomad_server_1]
#  jobspec = file("nomad/service.hcl")
#}
resource "nomad_job" "docker_registry" {
  depends_on = [outscale_vm.nomad_server_1]
  jobspec = file("nomad/docker_registry.hcl")
}
