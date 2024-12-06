variable "region" {
  description = "La región de AWS donde se despliega el recurso"
  type        = string
}

variable "app_name" {
  description = "Nombre de la aplicación AWS Amplify"
  type        = string
}

variable "repository_url" {
  description = "URL del repositorio de código fuente"
  type        = string
}

variable "oauth_token" {
  description = "Token OAuth para integrar el repositorio con Amplify"
  type        = string
}

variable "build_spec" {
  description = "Especificación de la configuración de compilación"
  type        = string
  default     = null
}

variable "platform" {
  description = "Plataforma de la aplicación (WEB, WEB_DYNAMIC)"
  type        = string
  default     = "WEB"
}

variable "custom_rules" {
  description = "Reglas personalizadas para redirección o manejo de rutas"
  type = list(object({
    source    = string
    target    = string
    status    = string
    condition = string
  }))
  default = []
}

variable "enable_branch_auto_build" {
  description = "Habilitar compilaciones automáticas para las ramas"
  type        = bool
  default     = true
}

variable "environment_variables" {
  description = "Variables de entorno para el proyecto Amplify"
  type        = map(string)
  default     = {}
}

variable "branches" {
  description = "Configuración de ramas para el proyecto Amplify"
  type = map(object({
    enable_auto_build     = bool
    stage                 = string
    framework             = string
    environment_variables = map(string)
  }))
  default = {}
}

variable "custom_domain" {
  description = "Nombre de dominio personalizado para la aplicación Amplify"
  type        = string
  default     = null
}

variable "default_branch" {
  description = "Nombre de la rama predeterminada para el dominio personalizado"
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para los recursos creados"
  type        = map(string)
  default     = {}
}
