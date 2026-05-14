# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
#
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }
#
# resource "yandex_vpc_subnet" "develop_b" {
#   name           = "${var.vpc_name}_b"
#   zone           = "ru-central1-b"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr_b
# }

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.second_task.network.id
  subnet_zones   = ["ru-central1-a", "ru-central1-b"]
  subnet_ids     = module.second_task.subnet_ids
  instance_name  = "webs"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.second_task.network.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.second_task.subnet_ids[0]]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    project = "analitics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars     = { ssh_key = local.ssh_public_key }
}

module "second_task" {
  source   = "./modules/second"
  vpc_name = "plan-b"
  subnets = [
    {
      name        = "module_subnet_a",
      zone        = "ru-central1-a",
      cidr_blocks = ["10.0.1.0/24"]
    },
    {
      name        = "module_subnet_b",
      zone        = "ru-central1-b",
      cidr_blocks = ["10.0.2.0/24"]
    }
  ]
}
