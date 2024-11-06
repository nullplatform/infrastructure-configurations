output "login_server" {
  description = "Azure Container Registry login server."
  value       = azurerm_container_registry.acr.login_server
}

output "token_name" {
  description = "Azure token name (user for docker login)"
  value       = var.token_name
}

output "token_password" {
  description = "Azure token password1 (password for docker login)"
  value       = azurerm_container_registry_token_password.password.password1[0].value
}
