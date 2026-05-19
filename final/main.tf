resource "yandex_vpc_network" "main_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "main_subnet" {
  name           = var.vpc_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.web_os_image
}

resource "yandex_compute_instance" "dev" {
  count = var.count_vm
  name  = "${var.vpc_name}-${count.index + 1}"

  resources {
    cores         = var.vpc_resources.default.cores
    memory        = var.vpc_resources.default.memory
    core_fraction = var.vpc_resources.default.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vpc_resources.default.hdd_size
      type     = var.vpc_resources.default.hdd_type
    }
  }

  scheduling_policy {
    preemptible = var.vpc_resources.default.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main_subnet.id
    security_group_ids = [yandex_vpc_security_group.main_sec.id]
    nat                = true
  }

  metadata = {
    serial-port-enable = true
    user-data          = data.template_file.cloudinit.rendered
  }
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yaml")
  vars     = { ssh_key = local.ssh_key }
}
