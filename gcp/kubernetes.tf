module "cert-manager" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/kubernetes/helm/cert-manager/gcp"

  depends_on = [module.nullplatform]

  project_id          = var.project_id
  domain_name         = var.domain_name
  service_account_key = module.gcp_cloud_provider_domain.keys["cert-manager"]
}

module "nullplatform" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/kubernetes/helm/nullplatform/gcp"

  service_account_key_base64 = base64encode(module.gcp_cloud_provider_sa.keys["gcp-cloud"])
  registry                   = module.repo.repository_name
}

module "istio" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/kubernetes/helm/istio"
}
