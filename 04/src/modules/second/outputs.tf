output "network" {
  value = yandex_vpc_network.module_network
}

output "subnet_name" {
  value = [for subnet in yandex_vpc_subnet.module_subnets : subnet.name]
}

output "subnet_ids" {
  value = [for subnet in yandex_vpc_subnet.module_subnets : subnet.id]
}
