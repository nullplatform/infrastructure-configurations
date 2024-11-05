resource "random_id" "repo_name" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    application_name = var.application_name
  }

  byte_length = 12
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.application_name}${random_id.repo_name.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
}