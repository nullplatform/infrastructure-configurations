module "nullplatform" {
  source       = "./modules/nullplatform/providers/config"
  account      = var.account
  cluster_name = module.aks.cluster_name

  azure_client_id       = module.credentials.client_id
  azure_client_secret   = module.credentials.client_secret
  azure_subscription_id = module.credentials.subscription_id
  azure_tenant_id       = module.credentials.tenant_id

  acr_login_server = module.acr.login_server
  acr_username     = module.acr.token_name
  acr_password     = module.acr.token_password

  depends_on = [
    module.aks
  ]
}


# resource "nullplatform_account" "test" {
#   name                = "updated-test-account"
#   repository_prefix   = "updated-prefix"
#   repository_provider = "gitlab"
#   slug               = "updated-test-account"
# }