output "all_volumes_created_with_docker_volumes" {
  description = "all volumes created with docker_volumes"
  value = module.docker_volumes.all_volumes_created
}