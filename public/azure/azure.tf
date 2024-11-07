locals {
  domain_name  = var.domain_name != null ? var.domain_name : "${var.organization}.nullapps.io"
  cluster_name = var.cluster_name != null ? var.cluster_name : "${var.organization}-${var.account}-cluster"
}

module "resource_group" {
  source       = "./modules/azure/resource-group"
  location     = var.location
  organization = var.organization
  account      = var.account
}

module "vnet" {
  source         = "./modules/azure/vnet"
  location       = module.resource_group.resource_group_location
  resource_group = module.resource_group.resource_group_name
  organization   = var.organization
  account        = var.account
  depends_on = [
    module.resource_group
  ]
}

module "dns" {
  source         = "./modules/azure/dns"
  resource_group = module.resource_group.resource_group_name
  domain_name    = local.domain_name
  depends_on = [
    module.resource_group
  ]
}

module "aks" {
  source              = "./modules/azure/aks"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  cluster_name        = local.cluster_name
  domain_name         = local.domain_name
  vnet_subnet_id      = module.vnet.private_subnet_ids[0]
  organization        = var.organization
  account             = var.account
  subscription_id     = var.azure_subscription_id
  depends_on = [
    module.dns,
    module.resource_group,
    module.vnet
  ]
}

module "credentials" {
  source  = "./modules/azure/credentials"
  account = var.account
}

module "acr" {
  source = "./modules/azure/acr"

  account             = var.account
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}
