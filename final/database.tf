# resource "yandex_mdb_mysql_cluster" "mysql-claster" {
#   name               = var.db_claster_name
#   environment        = "PRODUCTION"
#   network_id         = yandex_vpc_network.main_network.id
#   version            = var.db_version
#   security_group_ids = [yandex_vpc_security_group.main_sec.id]
#   resources {
#     resource_preset_id = "s2.micro"
#     disk_size          = var.db_size
#     disk_type_id       = var.vpc_resources.default.hdd_type
#   }
#
#   host {
#     zone             = var.default_zone
#     subnet_id        = yandex_vpc_subnet.main_subnet.id
#     assign_public_ip = true
#   }
#
# }
#
# resource "yandex_mdb_mysql_database" "db1" {
#   cluster_id = yandex_mdb_mysql_cluster.mysql-claster.id
#   name       = var.db_name
# }
#
# resource "yandex_mdb_mysql_user" "mysql-user" {
#   cluster_id = yandex_mdb_mysql_cluster.mysql-claster.id
#   name       = var.db_user
#   password   = var.db_password
#   permission {
#     database_name = yandex_mdb_mysql_database.db1.name
#     roles         = ["ALL"]
#   }
# }
