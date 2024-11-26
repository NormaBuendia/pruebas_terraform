locals {
  policies = jsondecode(file("policy.json"))
}

################################################################################
# Grupo de Reglas Stateless
################################################################################
resource "aws_networkfirewall_rule_group" "stateless" {
  name     = local.policies.stateless_rule_groups[0].name
  type     = local.policies.stateless_rule_groups[0].type
  capacity = local.policies.stateless_rule_groups[0].capacity


  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = local.policies.stateless_rule_groups[0].rules[0].priority
          
          rule_definition {
            actions = [local.policies.stateless_rule_groups[0].rules[0].actions]
            match_attributes {
              protocols = [local.policies.stateless_rule_groups[0].rules[0].match_attributes.protocols]
              destination_port {
                from_port = local.policies.stateless_rule_groups[0].rules[0].match_attributes.destination_port.from_port
                to_port   = local.policies.stateless_rule_groups[0].rules[0].match_attributes.destination_port.to_port
              }
               source {
                address_definition = local.policies.stateless_rule_groups[0].rules[0].match_attributes.source
              }
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
  name     = local.policies.stateful_rule_groups[0].name
  type     = local.policies.stateful_rule_groups[0].type
  capacity = local.policies.stateful_rule_groups[0].capacity

  rule_group {
    rules_source {
      rules_string = local.policies.stateful_rule_groups[0].rules
    }
  }
}

################################################################################
# Política de Firewall
################################################################################
resource "aws_networkfirewall_firewall_policy" "example" {
  name = var.firewall_policy_name

  firewall_policy {
    stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateless.arn
      priority = local.policies.stateless_rule_groups[0].rules[0].priority
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateful.arn
    }

    stateless_default_actions          = local.policies.stateless_default_actions
    stateless_fragment_default_actions = local.policies.stateless_fragment_default_actions
  }

  description = var.firewall_policy_description
}

################################################################################
# Firewall
################################################################################
# resource "aws_networkfirewall_firewall" "example" {
#   name                = var.firewall_name
#   firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
#   vpc_id              = var.vpc_id
#   description         = var.description

#   dynamic "subnet_mapping" {
#     for_each = var.subnet_ids
#     content {
#       subnet_id       = subnet_mapping.value
#     }
#   }

#   tags = var.tags

#   delete_protection               = var.delete_protection
#   firewall_policy_change_protection = var.firewall_policy_change_protection
#   subnet_change_protection        = var.subnet_change_protection
# }

resource "aws_networkfirewall_firewall" "example" {
  name                = var.firewall_name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
  vpc_id              = var.vpc_id
  description         = var.description

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping  # Mapeo dinámico de subredes.

    content {
      ip_address_type = try(subnet_mapping.value.ip_address_type, null) # Tipo de dirección IP (IPv4/IPv6).
      subnet_id       = subnet_mapping.value.subnet_id  # ID de la subred.
    }
  }

  tags = var.tags
  delete_protection               = var.delete_protection
  firewall_policy_change_protection = var.firewall_policy_change_protection
  subnet_change_protection        = var.subnet_change_protection
}

