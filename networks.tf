# We can split terraform code in multiple files like this
# Or we can use modules instead simples separated file

# network
resource "docker_network" "private_network" {
  name = var.network
}