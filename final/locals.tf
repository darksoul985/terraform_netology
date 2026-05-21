locals {
  ssh_key        = file("~/.ssh/id_ed25519.pub")
  registry_id    = yandex_container_registry.app_registry.id
  image_name     = "pyapp"
  image_tag      = "latest"
  full_image_url = "cr.yandex/${local.registry_id}/${local.image_name}:${local.image_tag}"


  vm_metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tpl", {
      ssh_user        = var.ssh_user
      ssh_public_key  = local.ssh_key
      db_host         = yandex_mdb_mysql_cluster.mysql-claster.host[0].fqdn
      db_name         = yandex_mdb_mysql_database.db1.name
      db_password     = yandex_mdb_mysql_user.mysql-user.password
      db_user         = yandex_mdb_mysql_user.mysql-user.name
      full_image_name = local.full_image_url
    })

    # vm_metadata = {
    #   user-data = templatefile("${path.module}/cloud-init.yaml.tpl", {
    #     ssh_user        = var.ssh_user
    #     ssh_public_key  = local.ssh_key
    #     db_host         = yandex_mdb_mysql_cluster.mysql-claster.host[0].fqdn
    #     db_name         = yandex_mdb_mysql_database.db1.name
    #     db_password     = yandex_mdb_mysql_user.mysql-user.password
    #     db_user         = yandex_mdb_mysql_user.mysql-user.name
    #     full_image_name = local.full_image_url
    #   })
  }
}
