
# Crea un bucket S3 con el nombre especificado y aplica etiquetas definidas
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name   # Nombre del bucket que se proporciona como variable
  tags   = var.tags          # Etiquetas asociadas al bucket
}

# Configura los controles de propiedad para el bucket S3
# Permite definir la propiedad de los objetos cargados, asegurando que el propietario del bucket tenga control total.
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id   # Referencia al bucket S3 creado previamente
  rule {
    object_ownership = var.object_ownership  # Establece la propiedad de los objetos cargados, configurable como variable
  }
}

# Habilita o deshabilita el versionado para el bucket S3
# El versionado es útil para mantener múltiples versiones de un objeto, lo que ayuda en la recuperación ante desastres o errores
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_bucket.id   # Referencia al bucket S3 creado previamente
  versioning_configuration {
    status = var.versioning_status  # Establece el estado del versionado (habilitado o deshabilitado)
  }
}

# Bloquea el acceso público al bucket S3
# Ayuda a proteger los datos sensibles evitando que sean accesibles públicamente por error
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.s3_bucket.id   # Referencia al bucket S3 creado previamente
  block_public_acls       = var.block_public_acls       # Bloquea las ACL públicas
  block_public_policy     = var.block_public_policy     # Bloquea las políticas públicas
  restrict_public_buckets = var.restrict_public_buckets # Restringe buckets públicos
  ignore_public_acls      = var.ignore_public_acls      # Ignora las ACL públicas en objetos
}

# Configura el ciclo de vida de los objetos dentro del bucket S3
# Las reglas de ciclo de vida permiten mover objetos a clases de almacenamiento más baratas o eliminarlos después de un cierto tiempo.
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_example" {
  bucket = aws_s3_bucket.s3_bucket.id   # Referencia al bucket S3 creado previamente

  # Define las reglas para el ciclo de vida de los objetos en el bucket
  rule {
    id     = var.lifecycle_rule_id    
    status = var.lifecycle_status    

    # Filtra los objetos que deben cumplir con esta regla, en este caso, con un prefijo específico
    filter {
      prefix = var.lifecycle_prefix  # Prefijo de los objetos que deben ser gestionados por esta regla
    }

    # Configura la transición de los objetos a una clase de almacenamiento más barata después de un número específico de días
    transition {
      days          = var.transition_days  # Número de días después de los cuales los objetos deben ser movidos
      storage_class = var.storage_class   # Clase de almacenamiento a la que se moverán los objetos
    }

    # Configura la expiración de los objetos, eliminándolos después de un número específico de días
    expiration {
      days = var.expiration_days  # Número de días después de los cuales los objetos deben ser eliminados
    }
  }
}

