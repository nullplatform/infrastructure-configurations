output "name_servers" {
  description = "A list of name servers"
  value       = module.dns.name_servers
}

output "domain_name" {
  description = "The domain name used for this configuration"
  value       = local.domain_name
}

output "client_id" {
  description = "Azure credentials client id."
  value       = module.credentials.client_id
}

output "client_secret" {
  description = "Azure credentials client secret (password)."
  value       = module.credentials.client_secret
  sensitive   = true
}
