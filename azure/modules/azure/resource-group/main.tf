resource "azurerm_resource_group" "nullplatform_resource_group" {
  name     = "rg-${var.organization}-${var.account}"
  location = var.location
  tags     = var.tags
}
