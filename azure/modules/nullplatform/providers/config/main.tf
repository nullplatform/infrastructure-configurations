resource "nullplatform_provider_config" "azure" {
  nrn  = var.nrn
  type = "azure-configuration"
  dimensions = var.env == null ? {} : {"env" : var.env}
  attributes = jsonencode({
    "authentication" : {
      "client_id" : var.azure_client_id
      "client_secret" : var.azure_client_secret
      "subscription_id" : var.azure_subscription_id
      "tenant_id" : var.azure_tenant_id
    },
    "networking" : {
      "application_domain" : true
      "domain_name" : var.domain_name
      "public_dns_zone_name" : var.domain_name,
      "public_dns_zone_resource_group_name" : var.azure_resource_group_id,
      "application_domain" : false
    },
    }
  )
}

resource "nullplatform_provider_config" "aks" {
  nrn  = var.nrn
  type = "aks-configuration"
  dimensions = {
    "env" : var.env
  }
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
