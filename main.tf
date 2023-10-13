# network
resource "docker_network" "private_network" {
  name = var.network
}
 
# volume db
resource "docker_volume" "wp_vol_db" {
  name = var.db_volume
}
 
# volumes fichiers wp
resource "docker_volume" "wp_vol_files" {
  name = var.wp_volume
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
  # complete values
  env = [
     "MYSQL_ROOT_PASSWORD=${var.db_root_pwd}",
     "MYSQL_DATABASE=${var.db_name}",
     "MYSQL_USER=${var.db_user}",
     "MYSQL_PASSWORD=${var.db_user_pwd}"
  ]

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

}


resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

module "docker_container_qos" {
  # providers = {
  #   docker = docker
  # }
  source = "./modules/docker_container_qos"
  name  = "ubuntu-foo"
  image = docker_image.ubuntu.image_id
  command = ["sleep", "infinity"]  
}
