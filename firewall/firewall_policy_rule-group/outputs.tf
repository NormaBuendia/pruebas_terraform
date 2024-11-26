output "firewall_id" {
  description = "ID del firewall creado"
  value       = aws_networkfirewall_firewall.example.id
}

output "firewall_policy_id" {
  description = "ID de la política de firewall"
  value       = aws_networkfirewall_firewall_policy.example.id
}

output "firewall_policy_description" {
  description = "Descripción de la política de firewall"
  value       = aws_networkfirewall_firewall_policy.example.description
}

output "stateless_rule_group_ids" {
  description = "IDs de los grupos de reglas sin estado"
  value       = aws_networkfirewall_rule_group.stateless[*].id
}

output "stateful_rule_group_ids" {
  description = "IDs de los grupos de reglas con estado"
  value       = aws_networkfirewall_rule_group.stateful[*].id
}
