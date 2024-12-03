terraform {
  source = "./"  # Ruta al módulo de AWS Shield
}

inputs = {
  region               = "us-west-2"
  name                 = "example-shield"

  # Configuración del Health Check
  health_check_ip      = "8.8.8.8"
  health_check_configuration = {
    ip_address        = "8.8.8.8"
    port              = 80
    type              = "HTTP"
    resource_path     = "/"
    failure_threshold = 3
    request_interval  = 30
  }

  # Activación de la protección de AWS Shield
  enable_shield        = true
  protection_group_id  = "custom-group-id"
  aggregation          = "SUM"
  resource_type        = ""  # Tipo de recurso para Route 53 Health Check

  resource_arn         = ""  # Dejar vacío si se genera dinámicamente el health check

  protection_group_config = [
    {
      id            = "example-group"
      aggregation   = "SUM"
      pattern       = "BY_RESOURCE_TYPE"
      resource_type = "ROUTE_53_HOSTED_ZONE"
    },
    {
      id            = "arbitrary-group"
      aggregation   = "MAX"
      pattern       = "ARBITRARY"
      resource_type = "NOT_APPLICABLE"
    }
  ]

  # Configuración del Health Check para Route 53
  route53_health_checks = {
    "example_health_check" = {
      resource_ip          = "8.8.8.8"  # Usar la IP directamente
      health_check_port    = 80
      health_check_type    = "HTTP"
      health_check_path    = "/"
      health_check_threshold = 3
      health_check_interval  = 30
    }
  }

  tags = {
    "Environment" = "dev"
  }
}
