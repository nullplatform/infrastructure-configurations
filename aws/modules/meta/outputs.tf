# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# S3 outputs
output "assets_bucket_arn" {
  description = "Assets bucket arn"
  value       = module.s3.assets_bucket_arn
}

output "parameters_bucket_arn" {
  description = "Parameters bucket arn"
  value       = module.s3.parameters_bucket_arn
}
