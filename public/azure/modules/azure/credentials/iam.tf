data "azurerm_client_config" "current" {}

resource "azuread_application_registration" "provider_account" {
  display_name = "${var.account}-nullplatform"
}

resource "azuread_application_password" "provider_credential" {
  application_id = azuread_application_registration.provider_account.id
}
