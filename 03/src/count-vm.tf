data "yandex_compute_image" "ubuntu" {
  family = var.web_os_image
}

resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.database]
  count      = 2
  name       = "${local.vm_name}-${count.index + 1}"
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

    subnet_id = yandex_vpc_subnet.develop.id
    # nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh_key
  }
}
