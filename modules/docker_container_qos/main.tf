# variables
variable "name" {
  description = "The Docker name to use for the container"
  type        = string
  # no default => required
}

variable "image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "network_mode" {
  description = "The network mode for the container"
  type        = string
  # default => not required
  default     = "bridge"
}

variable "ports" {
  description = "Port mapping for the container"
  type        = list(object({
    internal = number
    external = number
  }))
  default     = null
}

variable "mounts" {
  description = "A list of volume configurations for the container"
  type = list(object({
    container_path = string
    from_container = string
    host_path = string
    read_only = bool
    volume_name = string
  }))
  default = []
  # /!\ better empty array than null 
  # otherwise init according to null or not in .tf instructions
  # default = null
}

variable "env" {
  description = "Environment variables for the container"
  type        = list(string)
  default = null
}

variable "command" {
  description = "Command for the container"
  type        = list(string)
  default = null
}

# create container with input vars
resource "docker_container" "container" {
  # specific elements from modules
  restart = "always"
  # logging
  
  # properties form input vars
  name  = var.name
  image = var.image
  network_mode = var.network_mode
  command = var.command
  # mounts {
  #   for_each = { for idx, m in var.mounts : idx => m }
  #   type   = each.value.type
  #   target = each.value.target
  #   source = each.value.source
  # }
  dynamic "mounts" {
    for_each = var.mounts

    content {
      type   = mounts.value.type
      target = mounts.value.target
      source = mounts.value.source
    }
  }

  env = var.env
}
