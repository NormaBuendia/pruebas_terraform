variable "region" {
    description = "La region es Oregon"
    type        =  string
}

variable "instance_type" {
    description = "El tipo de instancia EC2"
    type        = string 
}

variable "ami" {
    description = "Ami ID para la instancia EC2"
    type        = string
}

variable "key_name" {
    description = "Nombre par de claves"
    type        = string
}

variable "cidr_block"{
    description = "El bloque CIRD para el VPC"
    type        = string
    default     = "10.0.0.0/16"
}