###cloud vars

variable "cloud_id" {
  type        = string
  default     = "b1gvo07bbcrqmf464p6n"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gsfofgv9oq920m73tc"
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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJrP1KjKKsVfezUYBpnRzrTLPI0Drcy1fjlXegnesRud soul@DevOps"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_os_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image OS"
}


variable "vm_web_platform" {
  type        = map(string)
  default     = { platform_id = "standard-v4a" }
  description = "names and standard default options"
}

# variable "vm_web_resource" {
#   type = object({
#     cores         = number,
#     memory        = number,
#     core_fraction = number
#   })
#   default = {
#     cores         = 2,
#     memory        = 1,
#     core_fraction = 20
#   }
#   description = "number of cores, memory, and core usage by the VM"
# }

variable "vms_resources" {
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
      memory        = 2,
      core_fraction = 20,
      hdd_size      = 10,
      hdd_type      = "network-hdd",
    },
    db = {
      cores         = 2,
      memory        = 4,
      core_fraction = 20
      hdd_size      = 10,
      hdd_type      = "network-ssd",
    }
  }
}

variable "metadata" {
  type = map(object({
    serial-port-enable = number,
    ssh-keys           = string
  }))
  default = {
    base = {
      serial-port-enable = 1,
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJrP1KjKKsVfezUYBpnRzrTLPI0Drcy1fjlXegnesRud soul@DevOps"
    }
  }
}


variable "test" {
  type = list(map(list(string)))
  default = [
    {
      "dev1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
        "10.0.1.7"
      ]
    },
    {
      "dev2" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
        "10.0.2.29"
      ]
    },
    {
      "prod1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
        "10.0.1.30"
      ]
    }
  ]
}
