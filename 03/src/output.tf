output "web" {
  value = [
    for vm in yandex_compute_instance.web :
    {
      name = vm.name,
      ip   = vm.network_interface[0].nat_ip_address,
      fqdn = vm.fqdn
    }
  ]
}
output "database" {
  value = [
    for vm in yandex_compute_instance.database :
    {
      name = vm.name,
      ip   = vm.network_interface[0].nat_ip_address,
      fqdn = vm.fqdn
    }
  ]
}

output "storage" {
  value = {
    name = yandex_compute_instance.storage.name,
    ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address,
    fqdn = yandex_compute_instance.storage.fqdn
  }
}
