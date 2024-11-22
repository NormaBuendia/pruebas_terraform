output "stateless_rule_group_arn" {
  description = "ARN del Stateless Rule Group creado"
  value       = aws_networkfirewall_rule_group.stateless.arn
}

output "stateful_rule_group_arn" {
  description = "ARN del Stateful Rule Group creado"
  value       = aws_networkfirewall_rule_group.stateful.arn
}


output "firewall_policy_arn" {
  description = "ARN de la política del firewall creada"
  value       = aws_networkfirewall_firewall_policy.example.arn
}

output "firewall_name" {
  description = "Nombre del firewall"
  value       = aws_networkfirewall_firewall.example.name
}

output "loaded_rule_groups" {
  value = local.rule_groups
}
