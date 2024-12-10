output "assets_bucket_arn" {
  description = "Assets bucket arn"
  value       = aws_s3_bucket.assets-bucket.arn
}

output "assets_bucket" {
  description = "Assets bucket"
  value       = aws_s3_bucket.assets-bucket.id
}

output "parameters_bucket_arn" {
  description = "Parameters bucket arn"
  value       = aws_s3_bucket.parameters-bucket.arn
}

output "parameters_bucket" {
  description = "Parameters bucket arn"
  value       = aws_s3_bucket.parameters-bucket.id
}
