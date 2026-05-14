resource "yandex_compute_disk" "vm_disk" {
  count = 3
  name  = "storage-disk-${count.index + 1}"
  type  = var.disk_storage.type
  size  = var.disk_storage.size
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  resources {
    cores         = var.vpc_resources.web.cores
    memory        = var.vpc_resources.web.memory
    core_fraction = var.vpc_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vpc_resources.web.hdd_size
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

  dynamic "secondary_disk" {
    for_each = { for disk in yandex_compute_disk.vm_disk : disk.name => disk }

    content {
      disk_id     = secondary_disk.value.id
      auto_delete = true
    }
  }
}
