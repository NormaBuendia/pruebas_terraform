# terraform {
#   backend "s3" {}
# }

# resource "aws_s3_bucket" "s3_bucket" {
#   bucket = var.name
#   acl    = var.acl # Define el nivel de acceso (como "private", "public-read").
#   tags = var.tags
# }

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = var.acl # Define el nivel de acceso (como "private", "public-read").
}


#Configura controles de propiedad en el bucket.
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = var.object_ownership # Define la propiedad de los objetos cargados 
  }
}
# Habilita o deshabilita el versionado en el bucket.
# Mantener versiones anteriores de objetos para recuperación o auditoría.
# Útil para proteger datos de modificaciones o eliminaciones accidentales.
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}
# Bloquea accesos públicos al bucket.
# Asegurar que el bucket no sea accesible públicamente. 
# Esto ayuda a proteger datos sensibles o privados contra accesos no autorizados.
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls
}











# resource "aws_s3_bucket" "this" {
#   bucket = var.name
# }

# # resource "aws_s3_bucket_acl" "this" {
# #   bucket = aws_s3_bucket.this.id
# #   acl    = var.acl
# # }

# resource "aws_s3_bucket_public_access_block" "this" {
#   bucket = aws_s3_bucket.this.id
#   block_public_acls   = var.block_public_acls
#   block_public_policy = var.block_public_policy
#   restrict_public_buckets = var.restrict_public_buckets
#   ignore_public_acls = var.ignore_public_acls
# }


# resource "aws_s3_object" "this" {
#   count = var.create ? 1 : 0 // Crea el recurso solo si 'var.create' es true, de lo contrario el conteo es 0.

#   bucket        = var.bucket // Nombre del bucket S3 donde se almacenará el objeto.
#   key           = var.key // Clave (nombre) del objeto en el bucket.
#   force_destroy = var.force_destroy // Permite la eliminación forzada del objeto, incluso si está versionado.

#   acl           = var.acl // Control de acceso del objeto (por ejemplo, 'private' o 'public-read').
#   storage_class = try(upper(var.storage_class), var.storage_class) // Define la clase de almacenamiento, usa la versión en mayúsculas si existe.

#   source         = var.file_source // Ruta al archivo local para subir al bucket.
#   content        = var.content // Contenido del objeto si se proporciona como texto.
#   content_base64 = var.content_base64 // Contenido del objeto en formato Base64, si es necesario.
#   etag           = var.etag // Identificador único (ETag) del objeto para verificación.

#   cache_control       = var.cache_control // Configuración de control de caché HTTP para el objeto.
#   content_disposition = var.content_disposition // Disposición de contenido HTTP (cómo se manejará el archivo al descargarse).
#   content_encoding    = var.content_encoding // Codificación del contenido HTTP (ej., 'gzip').
#   content_language    = var.content_language // Idioma del contenido HTTP (ej., 'en').
#   content_type        = var.content_type // Tipo MIME del contenido (ej., 'text/plain').
#   website_redirect    = var.website_redirect // URL de redireccionamiento para el objeto si se accede desde un navegador.
#   metadata            = var.metadata // Metadata personalizada asociada al objeto.

#   server_side_encryption = var.server_side_encryption // Define el tipo de cifrado en el lado del servidor (ej., 'AES256').
#   kms_key_id             = var.kms_key_id // ID de la clave KMS para cifrado si se usa KMS.
#   bucket_key_enabled     = var.bucket_key_enabled // Habilita el uso de una clave de bucket para objetos cifrados con KMS.

#   object_lock_legal_hold_status = try(tobool(var.object_lock_legal_hold_status) ? "ON" : upper(var.object_lock_legal_hold_status), var.object_lock_legal_hold_status) // Configura el estado de "Legal Hold" (retención legal) si está habilitado.
#   object_lock_mode              = try(upper(var.object_lock_mode), var.object_lock_mode) // Modo de bloqueo del objeto (ej., 'GOVERNANCE' o 'COMPLIANCE').
#   object_lock_retain_until_date = var.object_lock_retain_until_date // Fecha hasta la cual el objeto estará bloqueado.

#   source_hash = var.source_hash // Hash para verificación del archivo fuente, previene cargas repetidas.

#   tags = var.tags // Etiquetas asociadas al objeto.

#   dynamic "override_provider" { // Bloque dinámico para sobreescribir el proveedor con etiquetas predeterminadas.
#     for_each = var.override_default_tags ? [true] : [] // Solo se ejecuta si 'override_default_tags' es true.

#     content {
#       default_tags {
#         tags = {} // Sobrescribe cualquier etiqueta predeterminada si se usa este bloque.
#       }
#     }
#   }

#   lifecycle {
#     ignore_changes = [object_lock_retain_until_date] // Ignora cambios en esta propiedad para evitar reprocesamientos innecesarios.
#   }
# }
