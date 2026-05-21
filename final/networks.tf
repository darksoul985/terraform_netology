resource "yandex_vpc_network" "main_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "main_subnet" {
  name           = var.vpc_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = var.default_cidr
}

