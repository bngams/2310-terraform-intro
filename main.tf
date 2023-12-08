# We can put some code in separate files (see ./networks.tf)
# network
# resource "docker_network" "private_network" {
#   name = var.network
# }

# or in modules
module "docker_volumes" {
  source = "./modules/docker_volumes"
  db_volume = var.db_volume
  wp_volume = var.wp_volume
  all_volumes = [ "vol1", "vol2" ]
  # we can pass specific providers config to child module
  providers = { 
    childdocker = docker.my_docker
  }
}

# image maria
resource "docker_image" "mariadb" {
  name = var.db_image
}

# image wp
resource "docker_image" "wordpress" {
  name = var.wp_image
}

# resource db container
resource "docker_container" "db" {
  name  = var.db_host
  image = docker_image.mariadb.image_id
  network_mode = var.network
  mounts {
    type = "volume"
    target = "/var/lib/mysql"
    source = var.db_volume
  }
  #  healthcheck {
  #   test =["CMD", ""] 
  # }
  # wait , timeout
  # complete values
  # resources limits... 
  # qa container 
  env = [
     "MYSQL_ROOT_PASSWORD=${var.db_root_pwd}",
     "MYSQL_DATABASE=${var.db_name}",
     "MYSQL_USER=${var.db_user}",
     "MYSQL_PASSWORD=${var.db_user_pwd}"
  ]

  # depends_on = [docker_image.mariadb, docker_volume.wp_db_vol, ...] 
}

 
# resource wp container
resource "docker_container" "wp" {
  name  = var.wp_host
  image = docker_image.wordpress.image_id
  restart = "always"
  network_mode = var.network
  mounts {
    type = "volume"
    target = "/var/www/html"
    source = var.wp_volume
  }
  ports {
    internal = "80"
    external = var.wp_external_port
  }
  # complete values
  env = [
     "WORDPRESS_DB_HOST=${var.db_host}",
     "WORDPRESS_DB_NAME=${var.db_name}",
     "WORDPRESS_DB_USER=${var.db_user}",
     "WORDPRESS_DB_PASSWORD=${var.db_user_pwd}"
  ]
  #  healthcheck {
  #   test =["CMD", ""] 
  # }
  # wait , timeout
  # complete values
  # resources limits... 
  # qa container 
}


resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

module "docker_container_qos" {
  # providers = {
  #   docker = docker
  # }
  source = "./modules/docker_container_qos"
  name  = "ubuntu-foo-qos"
  image = docker_image.ubuntu.image_id
  command = ["sleep", "infinity"]  
}
