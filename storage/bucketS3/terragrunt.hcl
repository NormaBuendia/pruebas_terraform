terraform {
  source = "./"  # Ruta al módulo 
}

inputs = {
  region               = "us-east-1"  # Región en la que se creará el bucket S3, por ejemplo, "us-east-1".
  bucket_name          = "norma-ejemplito"  # Nombre del bucket S3. Este será el nombre único del bucket a crear.
  description          = "bucket-de-terraform"  # Descripción del bucket, útil para documentación o identificación.
  
  # Bloqueo de acceso público al bucket
  block_public_acls    = true  # Si se establece en 'true', bloquea las ACLs públicas del bucket (no permitirá accesos públicos).
  block_public_policy  = true  # Si se establece en 'true', bloquea las políticas públicas del bucket.
  restrict_public_buckets = true  # Restringe el acceso público a los buckets de S3, recomendado para seguridad.
  ignore_public_acls   = true  # Si se establece en 'true', ignora las ACLs públicas aplicadas al bucket, lo que mejora la seguridad.
  
  # Propiedad de los objetos cargados en el bucket
  object_ownership      = "BucketOwnerPreferred"  # Define quién posee los objetos en el bucket. Opciones: "BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced".
  
  # Configuración de versionado de objetos en el bucket
  versioning_status    = "Enabled"  # Si se establece en 'Enabled', habilita el versionado de los objetos en el bucket. Opciones: "Enabled", "Suspended".
  
  # Configuración de ciclo de vida de los objetos en el bucket
  lifecycle_prefix     = "backups/"  # Prefijo para los objetos que se gestionarán mediante las reglas de ciclo de vida (por ejemplo, objetos dentro de "backups/").
  transition_days      = 30  # Número de días después de los cuales los objetos se moverán a una clase de almacenamiento más económica.
  expiration_days      = 365  # Número de días después de los cuales los objetos serán eliminados automáticamente del bucket.
  
  # Configuración de reglas de ciclo de vida
  lifecycle_rule_id    = "storage-rule"  # Identificador único para la regla de ciclo de vida.
  lifecycle_status     = "Enabled"  # Estado de la regla de ciclo de vida. Si se establece en 'Enabled', la regla se aplica a los objetos.
  
  # Clase de almacenamiento para los objetos después de la transición
  storage_class        = "STANDARD_IA"  # Clase de almacenamiento a la que se moverán los objetos, "STANDARD_IA" es para almacenamiento de acceso infrecuente.
  
  # Etiquetas asociadas al bucket
  tags = {
    Environment = "dev"  # Etiqueta que indica el entorno, por ejemplo, "dev" para desarrollo.
    Owner       = "norma"  # Etiqueta que indica el propietario del bucket, útil para la administración y el seguimiento.
  }
}


