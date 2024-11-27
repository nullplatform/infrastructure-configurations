locals {
  dns_scope = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/dnszones/${var.domain_name}"
}

# This will be needed by cert-manager later
resource "azurerm_role_assignment" "dns_scope_role" {
  scope                = local.dns_scope
  role_definition_name = "DNS Zone Contributor"
  principal_id         = module.aks.kubelet_identity[0].object_id
}
