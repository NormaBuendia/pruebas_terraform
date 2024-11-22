
# Cargar reglas de grupo y políticas desde JSON
locals {
  rule_groups = jsondecode(file("rules.json"))
  policies = jsondecode(file("policy.json"))
}

# Grupo de Reglas Stateless
resource "aws_networkfirewall_rule_group" "stateless" {
  name     = local.rule_groups.stateless.name
  capacity = local.rule_groups.stateless.capacity
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = local.rule_groups.stateless.rules[0].priority

          rule_definition {
            actions = [local.rule_groups.stateless.rules[0].action]
            match_attributes {
              protocols = [local.rule_groups.stateless.rules[0].match_attributes.protocol]

              destination_port {
                from_port = local.rule_groups.stateless.rules[0].match_attributes.destination_ports.from
                to_port   = local.rule_groups.stateless.rules[0].match_attributes.destination_ports.to
              }

              source {
                address_definition = local.rule_groups.stateless.rules[0].match_attributes.source
              }
              destination {
                address_definition = local.rule_groups.stateless.rules[0].match_attributes.destination
              }
            }
          }
        }
      }
    }
  }
}

# Grupo de Reglas Stateful
resource "aws_networkfirewall_rule_group" "stateful" {
  name     = local.rule_groups.stateful.name
  capacity = local.rule_groups.stateful.capacity
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_string = local.rule_groups.stateful.rules
    }
  }

  lifecycle {
    ignore_changes = [rule_group]
  }
}


# Política de Firewall
resource "aws_networkfirewall_firewall_policy" "example" {
  name = local.policies.name

  firewall_policy {
    stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateless.arn
      priority     = local.policies.stateless_priority
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.stateful.arn
    }

    stateless_default_actions           = local.policies.stateless_default_actions
    stateless_fragment_default_actions = local.policies.stateless_fragment_default_actions
  }
}


# Firewall
resource "aws_networkfirewall_firewall" "example" {
  name                = "example-firewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
  vpc_id              = var.vpc_id

  dynamic "subnet_mapping" {
    for_each = var.subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = {
    Name = "example-firewall"
  }
}
