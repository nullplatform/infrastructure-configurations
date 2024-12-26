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
  value       = coalesce(length(keys(var.azure_credential)) > 0 ? var.azure_credential["client_id"] : null, length(module.credentials) > 0 ? module.credentials[0].client_id : null)
}

output "client_secret" {
  description = "Azure credentials client secret (password)."
  value       = coalesce(length(keys(var.azure_credential)) > 0 ? var.azure_credential["client_secret"] : null, length(module.credentials) > 0 ? module.credentials[0].client_secret : null)
  sensitive   = true
}
