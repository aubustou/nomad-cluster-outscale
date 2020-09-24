# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/opt/nomad"

# Enable the client
client {
  enabled = true
}

# Because we will potentially have two clients talking to the same
# Docker daemon, we have to disable the dangling container cleanup,
# otherwise they will stop each other's work thinking it was orphaned.
plugin "docker" {
  config {
    gc {
      dangling_containers {
        enabled = false
      }
    }
  }
}
