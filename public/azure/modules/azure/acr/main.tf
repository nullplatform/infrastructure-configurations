locals {
  # Remove any non alphanumeric value from name
  name = replace("${var.account}${random_id.repo_name.hex}", "/[^a-zA-Z0-9]/", "")
}

resource "random_id" "repo_name" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    account = var.account
  }

  byte_length = 12
}

resource "azurerm_container_registry" "acr" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  lifecycle {
    ignore_changes = [name]
  }
}

resource "azurerm_container_registry_scope_map" "scope" {
  name                    = local.name
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  actions = [
    "repositories/*/content/delete",
    "repositories/*/content/read",
    "repositories/*/content/write",
    "repositories/*/metadata/read",
    "repositories/*/metadata/write",
  ]

  lifecycle {
    ignore_changes = [name]
  }
}

resource "azurerm_container_registry_token" "token" {
  name                    = var.token_name
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  scope_map_id            = azurerm_container_registry_scope_map.scope.id
}

resource "azurerm_container_registry_token_password" "password" {
  container_registry_token_id = azurerm_container_registry_token.token.id

  password1 {
    expiry = var.token_password_expiry
  }
}
