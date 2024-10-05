################################################################################
# Outputs
################################################################################

# Output the ARN of the ACM certificate
output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

# Output the domain name of the ACM certificate
output "acm_certificate_domain_name" {
  description = "The domain name for which the ACM certificate is issued"
  value       = aws_acm_certificate.cert.domain_name
}
