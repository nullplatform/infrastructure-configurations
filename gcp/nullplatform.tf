module "dimensions" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/dimensions"
  nrn    = var.nrn
}

module "gcp_nullplatform" {
  source   = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/cloud/gcp"
  for_each = toset(module.dimensions.names)

  nrn                    = var.nrn
  dimension              = each.key
  project_id             = var.project_id
  domain_name            = var.domain_name
  public_dns_zone_name   = module.dns.public_domain_name
  private_dns_zone_name  = module.dns.private_domain_name
  use_application_domain = false
  credentials_file       = base64encode(module.gcp_cloud_provider_sa.keys["gcp-cloud"])
}

module "gke_nullplatform" {
  source       = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/container/gke"
  for_each     = toset(module.dimensions.names)
  nrn          = var.nrn
  dimension    = each.key
  cluster_name = module.gke.name
  location     = var.region
}


module "artifact" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/docker-server"

  nrn          = var.nrn
  path         = "${var.project_id}/${module.repo.repository_name}"
  login_server = "${var.region}-docker.pkg.dev"
  password     = base64encode(module.gcp_cloud_provider_sa.keys["gcp-cloud"])
}

module "github" {
  source                       = "git@github.com:nullplatform/main-terraform-modules.git//modules/nullplatform/github"
  count                        = var.github_enabled ? 1 : 0
  nrn                          = var.nrn
  organization                 = var.github_organization
  organization_installation_id = var.github_installation_id
}
