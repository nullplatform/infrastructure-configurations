data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}


resource "azuread_application" "provider_account" {
  display_name = "${var.account}-nullplatform"
}

resource "azuread_service_principal" "principal" {
  client_id    = azuread_application.provider_account.client_id
  use_existing = true
}

# resource "azuread_application_password" "provider_credential" {
#   application_id = azuread_application_registration.provider_account.id
#   display_name   = "rbac"
# }

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


# # Assign a role to the service principal
# resource "azurerm_role_assignment" "example" {
#   principal_id   = azuread_service_principal.example.id
#   role_definition_name = "Contributor"
#   scope          = azurerm_resource_group.example.id
# }


# resource "azurerm_role_definition" "definition" {
#   role_definition_id = "00000000-0000-0000-0000-000000000000"
#   name               = "nullplatform-role"
#   scope              = data.azurerm_subscription.primary.id

#   permissions {
#     actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
#     not_actions = []
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.primary.id,
#   ]
# }

# resource "azurerm_role_assignment" "assignment" {
#   name               = "00000000-0000-0000-0000-000000000000"
#   scope              = data.azurerm_subscription.primary.id
#   role_definition_id = azurerm_role_definition.definition.role_definition_resource_id
#   principal_id       = azuread_application_registration.provider_account.object_id
# }
