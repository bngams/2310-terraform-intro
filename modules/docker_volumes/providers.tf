# Set the required provider
terraform {
  required_providers {
    childdocker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.1"
    }
  }
}

# if we need specific conf
# provider "childdocker" {
# }

# otherwise pass parent provider conf when we call the module
# module "docker_volumes" {
#    ...    
#   providers = { 
#     childdocker = <from_parent_provider>
#   }
# } 
