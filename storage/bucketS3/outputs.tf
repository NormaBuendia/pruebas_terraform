output "bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "El ID del bucket S3"
}

output "bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "El ARN del bucket S3"
}