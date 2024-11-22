
# Primero definimos los inputs que necesitamos
inputs = {
  region                              = "us-west-2"
  vpc_id                              = "vpc-004914ef22b958447"
  subnet_ids                           = ["subnet-0b3d38d565ac24fa9"]
}

# Cargar el archivo JSON de manera correcta
# locals {
#   rule_groups = jsondecode(file("rules.json"))
#   policies = jsondecode(file("policy.json"))
# }


# Fuente del módulo de Terraform
terraform {
  source = "./"  # Asegúrate de que esta ruta sea correcta si el módulo de Terraform está en otro directorio
}

