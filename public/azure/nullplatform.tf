module "nullplatform" {
  source          = "./modules/nullplatform/providers/config"
  account         = var.account
  account_id      = var.account_id
  organization_id = var.organization_id
  cluster_name    = module.aks.cluster_name

  azure_client_id         = coalesce(var.azure_credential["client_id"], length(module.credentials) > 0 ? module.credentials[0].client_id : null)
  azure_client_secret     = coalesce(var.azure_credential["client_secret"], length(module.credentials) > 0 ? module.credentials[0].client_secret : null)
  azure_subscription_id   = var.azure_subscription_id
  azure_tenant_id         = var.azure_tenant_id
  azure_resource_group_id = local.resource_group_name

  acr_login_server = module.acr.login_server
  acr_username     = module.acr.token_name
  acr_password     = module.acr.token_password

  domain_name = local.domain_name

  depends_on = [
    module.aks
  ]
}

