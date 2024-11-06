resource "nullplatform_provider_config" "azure" {
  account    = var.account
  type       = "azure-configuration"
  dimensions = {}
  attributes = jsonencode({
    "authentication" : {
      "client_id" : azuread_application_registration.provider_account.client_id
      "tenant_id" : data.azurerm_client_config.current.tenant_id
      "client_secret" : azuread_application_password.provider_credential.value,
      "subscription_id" : data.azurerm_client_config.current.subscription_id
    },
    "networking" : {
      "domain_name" : "${var.account}.nullapps.io",
      "public_dns_zone_name" : "${var.account}.nullapps.io",
      "public_dns_zone_resource_group_name" : "rg-${var.account}-main",
    },
    }
  )
}

resource "nullplatform_provider_config" "aks" {
  account    = var.account
  type       = "aks-configuration"
  dimensions = {}
  attributes = jsonencode({
    "cluster" : {
      "id" : "${var.account}-main-cluster",
      "namespace" : "nullplatform",
      "resource_group" : "rg-${var.account}-main",
    },
    "gateway" : {
      "namespace" : "gateways",
      "public_name" : "gateway-public",
    },
    "networking" : {
      "public_balancer_ip" : "172.179.53.237",
      "balancer_ip" : "10.0.1.6",
    },
    "web_pool_provider" : "AZURE:WEB_POOL:AKS"
  })
  depends_on = [
    nullplatform_provider_config.azure
  ]
}

resource "nullplatform_provider_config" "acr" {
  account    = var.account
  type       = "docker-server"
  dimensions = {}
  attributes = jsonencode({
    "this_is_a_test":"a random value",
    "setup" : {
      "server" : "myapp4d47c7a49c89ede6d3a6c86a.azurecr.io",
      "path" : "test-myapp",
      "username" : azuread_application_registration.provider_account.client_id,
      "password" : azuread_application_password.provider_credential.value,
      "use_namespace" : false
    },
    "repository_provider" : "docker_server"
  })
  depends_on = [
    nullplatform_provider_config.azure
  ]
}
