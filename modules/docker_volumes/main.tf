# volume db
resource "docker_volume" "wp_vol_db" {
  provider = childdocker
  name = var.db_volume
}
 
# volumes fichiers wp
resource "docker_volume" "wp_vol_files" {
  provider = childdocker
  name = var.wp_volume
}

# create all volumes
resource "docker_volume" "all_volumes" {
  #  count = var.all_volumes.length??
  for_each = toset(var.all_volumes)
  name = each.key
}