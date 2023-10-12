variable "network" {
  description = "The docker network"
  type = string
  default = "wp_network"
}

variable "db_volume" {
  description = "The DB docker volume"
  type = string
  default = "wp_vol_db"
}

variable "wp_volume" {
  description = "The WP docker volume"
  type = string
  default = "wp_vol_files"
}

variable "db_image" {
  description = "The DB docker image"
  type = string
  default = "mariadb:latest"
}

variable "wp_image" {
  description = "The WP docker image"
  type = string
  default = "wordpress:latest"
}

variable "db_host" {
  description = "The DB host"
  type = string
  default = "db"
}

variable "db_root_pwd" {
  description = "The DB root pwd"
  type = string
  default = "root"
  sensitive = true
}

variable "db_name" {
  description = "The DB schema name"
  type = string
  default = "wp_db"
  sensitive = true
}

variable "db_user" {
  description = "The DB user for default schema"
  type = string
  default = "wp_dbu"
  sensitive = true
}

variable "db_user_pwd" {
  description = "The DB user pwd"
  type = string
  default = "wp_dbu_password"
  sensitive = true
}

variable "wp_host" {
  description = "The WP host"
  type = string
  default = "wp"
}

variable "wp_external_port" {
  description = "The WP external port"
  type = string
  default = "8080"
}
