data "yandex_compute_image" "ubuntu" {
  family = var.web_os_image
}

data "yandex_iam_service_account" "app_sa" {
  name = "service-one"
}

resource "yandex_compute_instance" "dev" {
  count    = var.count_vm
  name     = "${var.vpc_name}-${count.index + 1}"
  hostname = "${var.vpc_name}-${count.index + 1}"

  service_account_id = data.yandex_iam_service_account.app_sa.id

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

  metadata = local.vm_metadata
}

