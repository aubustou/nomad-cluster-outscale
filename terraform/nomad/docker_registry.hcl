job "docker-registry" {
  datacenters = ["dc1"]
  type        = "service"

  group "docker-registry" {
    # disable deployments
    update {
      max_parallel = 0
    }

    task "docker-registry-container" {
      driver = "docker"

      config {
        image   = "registry"
      }

      resources {
        cpu    = 200
        memory = 128
	network {
		mbits = 1
		port "http" {
			static = 5000
		}
	}
      }
    }
  }
}
