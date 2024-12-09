locals {
  policies = jsondecode(var.policies)  # Decodificar el JSON cargado desde Terragrunt
  create   = var.create                # Usamos la variable "create" para controlar la creación
}

################################################################################
# Grupo de Reglas Stateless
################################################################################
resource "aws_networkfirewall_rule_group" "stateless" {
  name     = local.policies.stateless_rule_groups[0].name  # Nombre del grupo de reglas.
  type     = local.policies.stateless_rule_groups[0].type  # Tipo de reglas (stateless/stateful).
  capacity = local.policies.stateless_rule_groups[0].capacity  # Capacidad máxima del grupo.

  # Configuración de las reglas stateless.
  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = local.policies.stateless_rule_groups[0].rules[0].priority  # Prioridad de la regla.

          rule_definition {
            actions = [local.policies.stateless_rule_groups[0].rules[0].actions]  # Acción de la regla.

            match_attributes {
              # Configuración del protocolo.
              protocols = [local.policies.stateless_rule_groups[0].rules[0].match_attributes.protocols]

              # Configuración del puerto de destino.
              destination_port {
                from_port = local.policies.stateless_rule_groups[0].rules[0].match_attributes.destination_port.from_port
                to_port   = local.policies.stateless_rule_groups[0].rules[0].match_attributes.destination_port.to_port
              }

              # Dirección de origen.
              source {
                address_definition = local.policies.stateless_rule_groups[0].rules[0].match_attributes.source
              }

              # Dirección de destino.
              destination {
                address_definition = local.policies.stateless_rule_groups[0].rules[0].match_attributes.destination
              }
            }
          }
        }
      }
    }
  }
}

################################################################################
# Grupo de Reglas Stateful
################################################################################
resource "aws_networkfirewall_rule_group" "stateful" {
  name     = local.policies.stateful_rule_groups[0].name  # Nombre del grupo de reglas.
  type     = local.policies.stateful_rule_groups[0].type  # Tipo de reglas (stateful).
  capacity = local.policies.stateful_rule_groups[0].capacity  # Capacidad máxima del grupo.

  # Configuración de las reglas stateful en formato de string.
  rule_group {
    rules_source {
      rules_string = local.policies.stateful_rule_groups[0].rules  # Reglas en formato Suricata.
    }
  }
}

################################################################################
# Política de Firewall
################################################################################
resource "aws_networkfirewall_firewall_policy" "example" {
  name = var.firewall_policy_name  # Nombre de la política de firewall.

  firewall_policy {
    # Referencia al grupo de reglas stateless. 
    # Si no hay ARN disponible, se excluye o se usa un valor vacío.
    stateless_rule_group_reference {
      resource_arn = try(aws_networkfirewall_rule_group.stateless.arn, "")  # Valor predeterminado si no hay ARN.
      priority = local.policies.stateless_rule_groups[0].rules[0].priority  # Prioridad para la referencia.
    }

    # Referencia al grupo de reglas stateful.
    stateful_rule_group_reference {
      resource_arn = try(aws_networkfirewall_rule_group.stateful.arn, "")  # Valor predeterminado si no hay ARN.
    }

    # Acciones predeterminadas para paquetes stateless.
    stateless_default_actions          = local.policies.stateless_default_actions
    stateless_fragment_default_actions = local.policies.stateless_fragment_default_actions
  }

  description = var.firewall_policy_description  # Descripción opcional de la política.
}

################################################################################
# Firewall
################################################################################
resource "aws_networkfirewall_firewall" "example" {
  name                = var.firewall_name  # Nombre del firewall.
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn  # ARN de la política de firewall.
  vpc_id              = var.vpc_id         # ID de la VPC asociada.
  description         = var.description    # Descripción opcional del firewall.

  # Configuración dinámica para el mapeo de subredes.
  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping  # Iteración sobre las subredes configuradas.

    content {
      ip_address_type = try(subnet_mapping.value.ip_address_type, null)  # Tipo de dirección IP (IPv4/IPv6).
      subnet_id       = subnet_mapping.value.subnet_id  # ID de la subred.
    }
  }

  tags = var.tags  # Etiquetas asociadas al recurso.

  # Configuración de protecciones adicionales.
  delete_protection               = var.delete_protection
  firewall_policy_change_protection = var.firewall_policy_change_protection
  subnet_change_protection        = var.subnet_change_protection
}
