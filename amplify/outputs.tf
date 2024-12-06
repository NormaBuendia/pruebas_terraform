output "app_id" {
  description = "ID de la aplicación Amplify"
  value       = aws_amplify_app.this.id
}

output "app_arn" {
  description = "ARN de la aplicación Amplify"
  value       = aws_amplify_app.this.arn
}

output "default_domain" {
  description = "Dominio predeterminado de la aplicación Amplify"
  value       = aws_amplify_app.this.default_domain
}

output "branch_urls" {
  description = "URLs de las ramas configuradas"
  value = { for k, v in aws_amplify_branch.branches : k => v.branch_name }
}
