locals {
  scope = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.ContainerRegistry/registries/${var.registry_name}"
}

# This will be needed by cert-manager later
resource "azurerm_role_assignment" "acr_role" {
  scope                = local.scope
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity[0].object_id
}
