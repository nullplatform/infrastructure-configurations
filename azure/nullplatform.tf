module "nullplatform" {
  source   = "./modules/nullplatform/providers/config"
  for_each = toset(module.dimensions.names)

  env          = each.key
  account      = var.account
  nrn          = var.nrn
  cluster_name = module.aks.cluster_name

  azure_client_id         = coalesce(length(keys(var.azure_credential)) > 0 ? var.azure_credential["client_id"] : null, length(module.credentials) > 0 ? module.credentials[0].client_id : null)
  azure_client_secret     = coalesce(length(keys(var.azure_credential)) > 0 ? var.azure_credential["client_secret"] : null, length(module.credentials) > 0 ? module.credentials[0].client_secret : null)
  azure_subscription_id   = var.azure_subscription_id
  azure_tenant_id         = var.azure_tenant_id
  azure_resource_group_id = local.resource_group_name

  domain_name = local.domain_name

  depends_on = [
    module.aks
  ]
}

module "assets-repository" {
  source = "../modules/nullplatform/docker-server"
  nrn    = var.nrn

  login_server = module.acr.login_server
  username     = module.acr.token_name
  password     = module.acr.token_password
}

module "code-repository" {
  source = "../modules/nullplatform/github"
  nrn    = var.nrn

  github_organization                 = var.github_organization
  github_organization_installation_id = var.github_organization_installation_id
}

module "dimensions" {
  source = "../modules/nullplatform/dimensions"

  nrn = var.nrn
}

