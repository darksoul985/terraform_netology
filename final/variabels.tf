# cloud and folder

variable "cloud_id" {
  type        = string
  description = "cloud organisation id"
}


variable "folder_id" {
  type        = string
  description = "folden on cloud organisation id"
}

# networks
variable "vpc_name" {
  type        = string
  default     = "web"
  description = "resource network name"
}

variable "vpc_subnet" {
  type        = string
  default     = "develop"
  description = "subnet name"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# VM resources

variable "count_vm" {
  type        = number
  default     = 2
  description = "how many instances should I create"
}


variable "web_os_image" {
  type        = string
  default     = "container-optimized-image"
  description = "image OS"
}

variable "vpc_resources" {
  type = map(object({
    cores         = number,
    memory        = number,
    core_fraction = number,
    hdd_size      = number,
    hdd_type      = string,
    preemptible   = bool
  }))
  default = {
    default = {
      cores         = 2,
      memory        = 1,
      core_fraction = 5,
      hdd_size      = 15,
      hdd_type      = "network-hdd",
      preemptible   = true,
    }
  }
}

# ssh-keys
variable "ssh_user" {
  type = string
  default = "main-user"
}

# security groups
variable "security_group_ingress" {
  description = "secrules ingress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить входящий ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий  http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
  ]
}

variable "security_group_egress" {
  description = "secrules egress"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить весь исходящий трафик"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}

# db options
variable "db_user" {
  type        = string
  sensitive   = true
  description = "Пользователь для MySQL"
}
variable "db_password" {
  type        = string
  sensitive   = true
  description = "Пароль для пользователя MySQL"
}

variable "db_claster_name" {
  type    = string
  default = "my-cluster"
}

variable "db_name" {
  type    = string
  default = "mysql-db"
}


variable "db_version" {
  type    = string
  default = "8.0"
}

variable "db_size" {
  type    = number
  default = 20
}

# containers
variable "registry_name" {
  type        = string
  default     = "final-project-registry"
  description = "имя репозитория контейнеров"
}
