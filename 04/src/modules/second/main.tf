resource "yandex_vpc_network" "module_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "module_subnets" {
  for_each       = { for idx, subnet in var.subnets : tostring(idx) => subnet }
  name           = each.value.name
  zone           = each.value.zone
  network_id     = yandex_vpc_network.module_network.id
  v4_cidr_blocks = each.value.cidr_blocks
}
