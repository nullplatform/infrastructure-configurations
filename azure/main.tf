locals {
  domain_name  = var.domain_name != null ? var.domain_name : "${var.organization}.nullapps.io"
  cluster_name = var.cluster_name != null ? var.cluster_name : "${var.organization}-${var.account}-cluster"
}

module "resource_group" {
  source = "./modules/azure/resource-group"
  providers = {
    azurerm = azurerm
  }
  location     = var.location
  organization = var.organization
  account      = var.account
}

module "vnet" {
  source = "./modules/azure/vnet"
  providers = {
    azurerm = azurerm
  }
  location       = module.resource_group.resource_group_location
  resource_group = module.resource_group.resource_group_name
  organization   = var.organization
  account        = var.account
  depends_on = [
    module.resource_group
  ]
}

module "azure_dns" {
  source = "./modules/azure/dns"
  providers = {
    azurerm = azurerm
  }
  resource_group = module.resource_group.resource_group_name
  domain_name    = local.domain_name
  depends_on = [
    module.resource_group
  ]
}

module "aks" {
  source = "./modules/azure/aks"
  providers = {
    azurerm = azurerm
  }
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  cluster_name        = local.cluster_name
  vnet_subnet_id      = module.vnet.private_subnet_ids[0]
  organization        = var.organization
  account             = var.account
  depends_on = [
    module.azure_dns,
    module.resource_group,
    module.vnet
  ]
}

/*module "aks_config" {
  source = "./modules/nullplatform/aks-config"
  providers = {
    kubernetes = kubernetes
    helm       = helm.aks
  }
  depends_on = [
    module.aks
  ]
  tls_secret_name = "wildcard-ey-poc-nullapps-io-tls"  # Delete this line
}*/

module "nullplatform" {
  source = "./modules/nullplatform"
  providers = {
    nullplatform = nullplatform
  }
  account      = var.account
  cluster_name = module.aks.cluster_name
  depends_on = [
    module.aks
  ]
}
