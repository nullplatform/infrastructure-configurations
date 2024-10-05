data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}


resource "azuread_application" "provider_account" {
  display_name = "${var.account}-nullplatform"
}

resource "azuread_service_principal" "principal" {
  client_id    = azuread_application.provider_account.client_id
  use_existing = true
}

resource "azuread_service_principal_password" "provider_credential" {
  display_name         = "rbac"
  service_principal_id = azuread_service_principal.principal.id
}

resource "azurerm_role_assignment" "assig2" {
  scope = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  # /providers/Microsoft.ContainerService/managedClusters/davidcohan"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.principal.object_id
}
