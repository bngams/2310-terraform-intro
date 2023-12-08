# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# providers
# we can override parent/root module config or create a new one
# provider "docker" {
  # host = "unix:///var/run/docker.sock"
# }
