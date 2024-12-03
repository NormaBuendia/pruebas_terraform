# Data para obtener información sobre la región y la cuenta de AWS
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Local para generar el prefijo del ARN de EIP
locals {
  arn_prefix = "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:eip-allocation"
}

# Crear Elastic IP (EIP)
resource "aws_eip" "example" {
  domain = "vpc"
}

# Crear Health Check en Route 53
resource "aws_route53_health_check" "example" {
  for_each = var.route53_health_checks  # Iterar sobre cada health check

  ip_address        = each.value.resource_ip
  port              = each.value.health_check_port
  type              = each.value.health_check_type
  resource_path     = each.value.health_check_path
  failure_threshold = each.value.health_check_threshold
  request_interval  = each.value.health_check_interval
}

# Configuración de protección en AWS Shield para el health check
resource "aws_shield_protection" "example" {
  for_each     = aws_route53_health_check.example  # Usar for_each para cada health check
  name         = var.name
  resource_arn = "${local.arn_prefix}/${aws_eip.example.id}"  # Generar el ARN con el EIP
  tags         = merge(local.tags, var.tags != null ? var.tags : {})
  depends_on   = [aws_route53_health_check.example]
}

# Crear un grupo de protección en AWS Shield
resource "aws_shield_protection_group" "example" {
  for_each = var.protection_group_config != null ? { for config in var.protection_group_config : config.id => config } : {}

  protection_group_id = each.value.id
  aggregation         = each.value.aggregation
  pattern             = each.value.pattern

  # Usar resource_type si el patrón es BY_RESOURCE_TYPE
  resource_type = each.value.pattern == "BY_RESOURCE_TYPE" ? each.value.resource_type : null

  # Usar members si el patrón es ARBITRARY y var.resource_arn tiene un valor
  members = each.value.pattern == "ARBITRARY" && var.resource_arn != "" ? [var.resource_arn] : null

  tags = merge(local.tags, var.tags)

  depends_on = [aws_shield_protection.example]
}

# Asociar los Health Checks de Route 53 con la protección de Shield
resource "aws_shield_protection_health_check_association" "example" {
  for_each            = aws_route53_health_check.example
  health_check_arn    = each.value.arn  # ARN de cada health check
  shield_protection_id = aws_shield_protection.example[each.key].id  # Asociamos con la protección Shield
}

# Local para etiquetas comunes
locals {
  tags = {
    "Environment" = "dev"  # Puedes agregar más etiquetas si es necesario
  }
}
