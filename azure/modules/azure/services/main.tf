resource "azurerm_storage_account" "tfstate_account" {
  name                     = "${var.organization}${var.account}tfstage"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "terraformstate"
  storage_account_name  = azurerm_storage_account.tfstate_account.name
  container_access_type = "private"
}
