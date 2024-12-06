
# Variables relacionadas con la región de AWS y recursos necesarios
terraform {
  source = "./"
}

inputs = {
  # Información básica de configuración
  region                           = "us-west-2"
  app_name = "Aws_Amplify_name"
  tags                             = {
    Name = "AWS_Amplify"
    Env  = "dev"
  }
}