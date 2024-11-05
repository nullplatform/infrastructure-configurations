resource "nullplatform_provider_config" "azure" {
  provider   = nullplatform
  account    = "ey-poc-main"
  type       = "azure-configuration"
  dimensions = {}
  attributes = jsonencode({
    "authentication" : {
      "client_id" : "6307dea1-d717-4ffc-9aa7-ce2f665d34f6",
      "tenant_id" : "ebf65bf9-2e0c-49f0-88a9-8cb51e713016",
      "client_secret" : "s2o8Q~_jW8rUSTdwtuA3khep-y-v_Cs20dtoudys",
      "subscription_id" : "4f01781f-c243-43cd-bf9a-5532f6379f9d"
    },
    "networking" : {
      "domain_name" : "ey-poc.nullapps.io",
      "public_dns_zone_name" : "ey-poc.nullapps.io",
      "public_dns_zone_resource_group_name" : "rg-ey-demo-main",
    },
    }
  )
}

resource "nullplatform_provider_config" "aks" {
  provider   = nullplatform
  account    = "ey-poc-main"
  type       = "aks-configuration"
  dimensions = {}
  attributes = jsonencode({
    "cluster" : {
      "id" : "ey-demo-main-cluster",
      "namespace" : "nullplatform",
      "resource_group" : "rg-ey-demo-main",
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
