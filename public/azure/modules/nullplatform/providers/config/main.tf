resource "nullplatform_provider_config" "azure" {
  nrn        = "organization=${var.organization_id}:account=${var.account_id}"
  type       = "azure-configuration"
  dimensions = {}
  attributes = jsonencode({
    "authentication" : {
      "client_id" : var.azure_client_id
      "client_secret" : var.azure_client_secret
      "subscription_id" : var.azure_subscription_id
      "tenant_id" : var.azure_tenant_id
    },
    "networking" : {
      "domain_name" : var.domain_name
      "public_dns_zone_name" : var.domain_name,
      "public_dns_zone_resource_group_name" : var.azure_resource_group_id,
      "application_domain" : false
    },
    }
  )
}

resource "nullplatform_provider_config" "aks" {
  nrn        = "organization=${var.organization_id}:account=${var.account_id}"
  type       = "aks-configuration"
  dimensions = {}
  attributes = jsonencode({
    "cluster" : {
      "id" : var.cluster_name,
      "namespace" : "nullplatform",
      "resource_group" : var.azure_resource_group_id,
    },
    "gateway" : {
      "namespace" : "gateways",
      "public_name" : "gateway-public",
      "private_name" : "gateway-private"
    },
  })
  depends_on = [
    nullplatform_provider_config.azure
  ]
}

resource "nullplatform_provider_config" "acr" {
  nrn        = "organization=${var.organization_id}:account=${var.account_id}"
  type       = "docker-server"
  dimensions = {}
  attributes = jsonencode({
    "setup" : {
      "server" : var.acr_login_server,
      "path" : "nullplatform",
      "username" : var.acr_username,
      "password" : var.acr_password,
      "use_namespace" : false
    },
    "repository_provider" : "docker_server"
  })
  depends_on = [
    nullplatform_provider_config.azure
  ]
}
