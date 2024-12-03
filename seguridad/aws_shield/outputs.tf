output "shield_protection" {
  value       = length(aws_shield_protection.example) > 0 ? [for protection in aws_shield_protection.example : protection.id] : []
  description = "IDs de protecciones avanzadas de AWS Shield creadas y los recursos asignados"
}

output "shield_protection_group" {
  value = length(aws_shield_protection_group.example) > 0 ? aws_shield_protection_group.example[keys(aws_shield_protection_group.example)[0]].id : null
  description = <<EOT
  ID del grupo de recursos protegidos que serán gestionados colectivamente por AWS Shield Advance.
  Devuelve 'null' si no se ha creado ningún grupo de protección.
  EOT
}


output "route53_health_check" {
  value       = length(aws_route53_health_check.example) > 0 ? [for hc_key, hc in aws_route53_health_check.example : hc.arn] : []
  description = "Lista de ARNs de los health checks de Amazon Route53 asociados"
}

output "shield_protection_health_check_association" {
  value = length(aws_shield_protection_health_check_association.example) > 0 ? [for assoc in aws_shield_protection_health_check_association.example : assoc.id] : []
  description = <<EOT
IDs de las asociaciones entre controles de estado de Amazon Route53 y recursos protegidos con AWS Shield Advance.
Devuelve una lista vacía si no hay asociaciones creadas.
EOT
}
