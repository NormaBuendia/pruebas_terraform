variable "region" {
  description = "La región de AWS donde se despliega el recurso"
  type        = string
}

variable "tags" {
  description = "Un mapa de etiquetas que se agregarán a todos los recursos"
  type        = map(string)
}

variable "description" {
  description = "Una descripción amigable del grupo de reglas"
  type        = string
}

variable "name" {
  description = "El nombre del bucket"
  type        = string
}

variable "acl" {
  description = "Control de acceso del bucket"
  type        = string
}

variable "block_public_acls" {
  description = "Si Amazon S3 debería bloquear las ACL públicas para este depósito"
  type        = bool
}

variable "block_public_policy" {
  description = "Si Amazon S3 debería bloquear las políticas de depósito público para este depósito"
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Si Amazon S3 debería restringir los buckets públicos"
  type        = bool
}

variable "ignore_public_acls" {
  description = "Si Amazon S3 debería ignorar las ACL públicas"
  type        = bool
}

variable "object_ownership" {
  description = "Define la propiedad de los objetos en el bucket"
  type        = string
  default     = "ObjectWriter"
}

variable "versioning_status" {
  description = "Habilita o deshabilita el versionado del bucket S3"
  type        = string
}
