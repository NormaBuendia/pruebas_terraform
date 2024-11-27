################################################################################
# Variables Generales para la Configuración del Firewall
################################################################################

# Región de AWS
variable "region" {
  description = "Región de AWS"
  type        = string
}

# ID de la VPC
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

# ID de la subnet
variable "subnet_ids" {
  description = "Lista de subnets asociadas al firewall"
  type        = list(string)
}

# Variables opcionales para etiquetas
variable "tags" {
  description = "Etiquetas para asociar a los recursos"
  type        = map(string)
  default     = {}
}

# Configuración para cifrar los datos del firewall
variable "encryption_configuration" {
  description = "Configuración para cifrar los datos del firewall."
  type        = list(object({
    key_id = string
  }))
  default = []
}

# Protección contra eliminación del firewall
variable "delete_protection" {
  description = "Protección contra eliminación del firewall."
  type        = bool
  default     = false
}

# Descripción del firewall
variable "description" {
  description = "Descripción del firewall."
  type        = string
}

# Protección contra cambios en la política del firewall
variable "firewall_policy_change_protection" {
  description = "Protección contra cambios en la política del firewall."
  type        = bool
}

# Nombre del firewall
variable "firewall_name" {
  description = "Nombre del firewall."
  type        = string
}

# Protección contra cambios en las subredes
variable "subnet_change_protection" {
  description = "Protección contra cambios en las subredes."
  type        = bool
}

# Mapeo de subredes para el firewall
variable "subnet_mapping" {
  description = "Mapeo de subredes para el firewall."
  type        = list(object({
    subnet_id       = string
    ip_address_type = string
  }))
  default     = []
}


# Flag para crear el recurso
variable "create" {
  description = "Flag para crear el recurso."
  type        = bool
  default     = true
}

# Flag para crear configuración de logging
variable "create_logging_configuration" {
  description = "Flag para crear configuración de logging."
  type        = bool
  default     = false
}

# Nombre de la política del firewall
variable "firewall_policy_name" {
  description = "El nombre de la política del firewall"
  type        = string
}

# Descripción de la política del firewall
variable "firewall_policy_description" {
  description = "Descripción de la política del firewall"
  type        = string
}

# variable "policies" {
#   description = "Políticas de configuración del firewall, cargadas desde un archivo JSON externo"
#   type        = string
# }

################################################################################
# Variables Generales para la Configuración del Firewall
################################################################################

# # Región de AWS
# variable "region" {
#   description = "Región de AWS"
#   type        = string
# }

# # ID de la VPC
# variable "vpc_id" {
#   description = "ID de la VPC"
#   type        = string
# }

# # ID de la subnet
# variable "subnet_ids" {
#   description = "Lista de subnets asociadas al firewall"
#   type        = list(string)
# }

# # Variables opcionales para etiquetas
# variable "tags" {
#   description = "Etiquetas para asociar a los recursos"
#   type        = map(string)
#   default     = {}
# }

# # Configuración para cifrar los datos del firewall
# variable "encryption_configuration" {
#   description = "Configuración para cifrar los datos del firewall."
#   type        = list(object({
#     key_id = string
#   }))
#   default = []
# }

# # Protección contra eliminación del firewall
# variable "delete_protection" {
#   description = "Protección contra eliminación del firewall."
#   type        = bool
#   default     = false
# }

# # Descripción del firewall
# variable "description" {
#   description = "Descripción del firewall."
#   type        = string
# }

# # Protección contra cambios en la política del firewall
# variable "firewall_policy_change_protection" {
#   description = "Protección contra cambios en la política del firewall."
#   type        = bool
# }

# # Nombre del firewall
# variable "firewall_name" {
#   description = "Nombre del firewall."
#   type        = string
# }

# # Protección contra cambios en las subredes
# variable "subnet_change_protection" {
#   description = "Protección contra cambios en las subredes."
#   type        = bool
# }

# # Mapeo de subredes para el firewall
# variable "subnet_mapping" {
#   description = "Mapeo de subredes para el firewall."
#   type        = list(object({
#     subnet_id       = string
#     ip_address_type = string
#   }))
#   default     = []
# }

# # Flag para crear el recurso
# variable "create" {
#   description = "Flag para crear el recurso."
#   type        = bool
#   default     = true
# }

# # Flag para crear configuración de logging
# variable "create_logging_configuration" {
#   description = "Flag para crear configuración de logging."
#   type        = bool
#   default     = false
# }

# # Nombre de la política del firewall
# variable "firewall_policy_name" {
#   description = "El nombre de la política del firewall"
#   type        = string
# }

# # Descripción de la política del firewall
# variable "firewall_policy_description" {
#   description = "Descripción de la política del firewall"
#   type        = string
# }
# variable "policies" {
#   description = "Políticas de configuración del firewall, cargadas desde un archivo JSON externo"
#   type        = string  # Cambiar a 'string' ya que el contenido será cargado como texto
# }

