variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID para asociar el firewall"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets asociadas al firewall"
  type        = list(string)
}
