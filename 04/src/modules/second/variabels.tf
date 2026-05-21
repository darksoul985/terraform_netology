variable "vpc_name" {
  type        = string
  description = "resource network name"
}

variable "subnets" {
  type = list(object({
    name        = string,
    zone        = string,
    cidr_blocks = list(string)
  }))
  description = "a list with data for creating subnets"
}

