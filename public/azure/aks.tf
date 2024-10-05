module "helm" {
  source = "./modules/helm"

  client_id           = module.aks.kubelet_client_id
  domain_name         = local.domain_name
  resource_group_name = local.resource_group_name
  subscription_id     = var.azure_subscription_id
}

