resource "yandex_compute_instance" "database" {
  for_each = { for name in var.main_vm : name => local.each_vm_config[name] }
  name     = each.key
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vpc_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
      type     = var.vpc_resources.web.hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh_key
  }
}
