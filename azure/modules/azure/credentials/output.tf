output "client_id" {
  description = "Azure credentials client id."
  value       = azuread_application_registration.provider_account.client_id
}

output "client_secret" {
  description = "Azure credentials client secret (password)."
  value       = azuread_application_password.provider_credential.value
}

output "subscription_id" {
  description = "Azure subscription_id."
  value       = data.azurerm_client_config.current.subscription_id
}

output "tenant_id" {
  description = "Azure tenant id."
  value       = data.azurerm_client_config.current.tenant_id
}
