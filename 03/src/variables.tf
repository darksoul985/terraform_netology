###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vpc_resources" {
  type = map(object({
    cores         = number,
    memory        = number,
    core_fraction = number,
    hdd_size      = number,
    hdd_type      = string,
  }))
  default = {
    web = {
      cores         = 2,
      memory        = 1,
      core_fraction = 5,
      hdd_size      = 10,
      hdd_type      = "network-hdd",
    }
  }
}

variable "web_os_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image OS"
}


variable "main_vm" {
  type    = set(string)
  default = ["main", "replica"]
}

variable "each_vm" {
  type = list(object(
    {
      vm_name     = string,
      cpu         = number,
      ram         = number,
      disk_volume = number
  }))
  default = [
    {
      vm_name     = "main",
      cpu         = 4,
      ram         = 6,
      disk_volume = 10
    },
    {
      vm_name     = "replica",
      cpu         = 2,
      ram         = 2,
      disk_volume = 15
    }
  ]
}

variable "disk_storage" {
  type = map(any)
  default = {
    type = "network-hdd",
    size = 1,
  }
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}
