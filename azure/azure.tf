locals {
  domain_name         = var.domain_name != null ? var.domain_name : "${var.organization}.nullapps.io"
  cluster_name        = var.cluster_name != null ? var.cluster_name : "${var.organization}-${var.account}-cluster"
  resource_group_name = coalesce(var.azure_resource_group_name, length(module.resource_group) > 0 ? module.resource_group[0].resource_group_name : null)
}

module "resource_group" {
  source       = "./modules/azure/resource-group"
  count        = var.azure_resource_group_name == null ? 1 : 0
  location     = var.location
  organization = var.organization
  account      = var.account
  tags         = var.tags
}

module "vnet" {
  source         = "./modules/azure/vnet"
  count          = length(keys(var.azure_vnet)) > 0 ? 0 : 1
  location       = var.location
  resource_group = local.resource_group_name
  organization   = var.organization
  account        = var.account
  depends_on = [
    module.resource_group
  ]
}

module "services" {
  source         = "./modules/azure/services"
  organization   = var.organization
  account        = var.account
  location       = var.location
  resource_group = local.resource_group_name
}

module "dns" {
  source         = "./modules/azure/dns"
  resource_group = local.resource_group_name
  domain_name    = local.domain_name
  depends_on = [
    module.resource_group
  ]
}

module "aks" {
  source              = "./modules/azure/aks"
  resource_group_name = local.resource_group_name
  location            = var.location
  cluster_name        = local.cluster_name
  domain_name         = local.domain_name
  vnet_subnet_id      = coalesce(length(keys(var.azure_vnet)) > 0 ? var.azure_vnet["private_subnet_id"] : null, length(module.vnet) > 0 ? module.vnet[0].private_subnet_ids[0] : null)
  organization        = var.organization
  account             = var.account
  registry_name       = module.acr.registry_name
  subscription_id     = var.azure_subscription_id
  depends_on = [
    module.dns
  ]
}

module "credentials" {
  source              = "./modules/azure/credentials"
  count               = length(keys(var.azure_credential)) > 0 ? 0 : 1
  account             = var.account
  cluster_name        = local.cluster_name
  resource_group_name = local.resource_group_name
  subscription_id     = var.azure_subscription_id
}

module "acr" {
  source = "./modules/azure/acr"

  account             = var.account
  resource_group_name = local.resource_group_name
  location            = var.location
}
