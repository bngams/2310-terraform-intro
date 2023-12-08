variable "db_volume" {
  description = "db volume name"
  type        = string
  default = null
}

variable "wp_volume" {
  description = "wp volume name"
  type        = string
  default = null
}

# Create all volumes from list ["vol1", "vol2"] 
variable "all_volumes" {
  description = "all volumes to create"
  type        = list(string)
  default = null
}