
output "parameters_encryption_arn" {
  description = "Secret manager arn to encrypt parameters into parameters bucket"
  value       = aws_secretsmanager_secret.nullservice_params_encryption.arn
}

output "parameters_encryption" {
  description = "Secret manager arn to encrypt parameters into parameters bucket"
  value       = aws_secretsmanager_secret.nullservice_params_encryption.name
}
