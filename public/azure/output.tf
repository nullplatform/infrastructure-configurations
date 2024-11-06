output "name_servers" {
  description = "A list of name servers"
  value       = module.dns.name_servers
}

output "domain_name" {
  description = "The domain name used for this configuration"
  value       = local.domain_name
}