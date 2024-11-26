
# Variables relacionadas con la región de AWS y recursos necesarios
terraform {
  source = "./"
}

inputs = {
  # Información básica de configuración
  region                           = "us-west-2"
  vpc_id                           = "vpc-004914ef22b958447" # vpc por defecto
  subnet_ids                       = ["subnet-0b3d38d565ac24fa9"] # subnet por defecto
  tags                             = {
    Name = "MyFirewall"
    Env  = "dev"
  }

  # Configuración de cifrado
  encryption_configuration = []

  # Configuración de protección y creación
  delete_protection               = false
  description                     = "Firewall description"
  firewall_policy_change_protection = false
  firewall_name                   = "my-firewall"

  subnet_change_protection        = false
  subnet_mapping = [
    {
      subnet_id       = "subnet-0b3d38d565ac24fa9"
      ip_address_type = "IPV4"
    }
  ]

  # Variables relacionadas con la política del firewall
  firewall_policy_name            = "my-firewall-policy"
  firewall_policy_description     = "Descripción de la política del firewall"
}
