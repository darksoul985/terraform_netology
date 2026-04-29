variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop-db"
  description = "VPC network & subnet name"
}

variable "vm_db_platform" {
  type        = map(string)
  default     = { platform_id = "standard-v4a" }
  description = "names and standard default options"
}

# variable "vm_db_resource" {
#   type = object({
#     cores         = number,
#     memory        = number,
#     core_fraction = number
#   })
#   default = {
#     cores         = 2,
#     memory        = 2,
#     core_fraction = 20
#   }
#   description = "number of cores, memory, and core usage by the VM"
# }
