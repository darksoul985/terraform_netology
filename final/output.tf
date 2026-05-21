output "servers_ips" {
  value = yandex_compute_instance.dev[*].network_interface[0].nat_ip_address
}

output "network_id" {
  value = yandex_vpc_network.main_network.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.main_subnet.id
}

output "image_url" {
  value = local.full_image_url
}
