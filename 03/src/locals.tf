locals {
  vm_name        = "web"
  each_vm_config = { for vm in var.each_vm : vm.vm_name => vm }
  ssh_key        = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  # storage_data = try(
  #   {
  #     name       = yandex_compute_instance.storage.name,
  #     ip_address = yandex_compute_instance.storage.network_interface[0].nat_ip_address,
  #     fqdn       = yandex_compute_instance.storage.fqdn,
  #   },
  #   null
  # )
}

