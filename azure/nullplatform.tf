/*module "aks_config" {
  source = "./modules/nullplatform/providers/aks"
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
  source       = "./modules/nullplatform/providers/config"
  account      = var.account
  cluster_name = module.aks.cluster_name

  azure_client_id       = module.credentials.client_id
  azure_client_secret   = module.credentials.client_secret
  azure_subscription_id = module.credentials.subscription_id
  azure_tenant_id       = module.credentials.tenant_id

  depends_on = [
    module.aks
  ]
}