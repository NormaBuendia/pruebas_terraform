variable "region" {
  description = "La región de AWS donde se despliega el recurso"
  type        = string
}

variable "name" {
  description = "Nombre para la Protección que se ha creado"
  type        = string
}

variable "protection_group_config" {
  description = <<EOT
  Configuración del grupo de protección de AWS Shield:
  - `id`: Nombre del grupo de protección o `protection_group_id` (ID del grupo).
  - `aggregation`: Cómo AWS Shield combina los datos de recursos para detectar y mitigar eventos (`SUM`, `MEAN`, `MAX`).
  - `pattern`: Criterios para seleccionar los recursos protegidos (`ARBITRARY`, `ALL`, `BY_RESOURCE_TYPE`).
  - `resource_type`: Tipo de recurso incluido en el grupo. Obligatorio solo si `pattern` es `BY_RESOURCE_TYPE`.
  EOT
  type = list(object({
    id            = string
    aggregation   = string
    pattern       = string
    resource_type = optional(string)
  }))
}

variable "tags" {
  description = "Mapa de clave-valor de etiquetas para los recursos creados"
  type        = map(string)
  default     = {}
}

variable "route53_health_checks" {
  description = "Configuración de los health checks para Route 53"
  type = map(object({
    resource_ip          = string
    health_check_port    = number
    health_check_type    = string
    health_check_path    = string
    health_check_threshold = number
    health_check_interval  = number
  }))
}

variable "enable_shield" {
  description = "Activar o desactivar la protección de Shield"
  type        = bool
}

variable "protection_group_id" {
  description = "ID para el grupo de protección de AWS Shield"
  type        = string
}

variable "aggregation" {
  description = "Método de agregación para el grupo de protección (SUM, MEAN, MAX)"
  type        = string
  validation {
    condition     = contains(["SUM", "MEAN", "MAX"], var.aggregation)
    error_message = "Valores válidos para `aggregation`: SUM, MEAN, MAX."
  }
}

variable "resource_type" {
  description = "Tipo de recurso protegido (p. ej., ELASTIC_IP, APPLICATION_LOAD_BALANCER)"
  type        = string
}

variable "health_check_ip" {
  description = "IP pública para el health check (si no se proporciona una IP específica)."
  type        = string
  default     = null
}

variable "health_check_configuration" {
  description = "Configuración detallada para los health checks"
  type = object({
    ip_address        = string
    port              = number
    type              = string
    resource_path     = string
    failure_threshold = number
    request_interval  = number
  })
  default = null
}


variable "resource_arn" {
  description = "ARN (Amazon Resource Name) del recurso a proteger (por ejemplo, Health Check de Route 53)"
  type        = string
  default     = ""
}