module "nullplatform" {
  source       = "./modules/nullplatform/providers/config"
  account      = var.account
  cluster_name = module.aks.cluster_name

  azure_client_id             = module.credentials.client_id
  azure_client_secret         = module.credentials.client_secret
  azure_subscription_id       = module.credentials.subscription_id
  azure_tenant_id             = module.credentials.tenant_id
  azure_dns_resource_group_id = module.resource_group.resource_group_name

  acr_login_server = module.acr.login_server
  acr_username     = module.acr.token_name
  acr_password     = module.acr.token_password

  domain_name = local.domain_name

  depends_on = [
    module.aks
  ]
}

