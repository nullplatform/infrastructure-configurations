module "gcp_cloud_provider_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.0"
  project_id    = var.project_id
  prefix        = "nullplatform"
  generate_keys = true
  names         = ["gcp-cloud"]
  project_roles = [
    "${var.project_id}=>roles/domains.admin",
    "${var.project_id}=>roles/dns.admin",
    "${var.project_id}=>roles/compute.admin",
    "${var.project_id}=>roles/container.admin",
    "${var.project_id}=>roles/container.clusterAdmin",
    "${var.project_id}=>roles/storage.admin",
    "${var.project_id}=>roles/compute.networkAdmin",
    "${var.project_id}=>roles/servicenetworking.networksAdmin",
    "${var.project_id}=>roles/artifactregistry.admin"
  ]
}

module "gcp_cloud_provider_domain" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.0"
  project_id    = var.project_id
  prefix        = "nullplatform"
  generate_keys = true
  names         = ["cert-manager"]
  project_roles = [
    "${var.project_id}=>roles/domains.admin",
  "${var.project_id}=>roles/dns.admin"]
}

module "gke" {
  source       = "git@github.com:nullplatform/main-terraform-modules.git//modules/gcp/gke?ref=feature/initial_modules_gcp"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  environment  = "main"
  network_id   = module.vpc.vpc_id
  subnet_id    = module.vpc.subnets[0] // Module accepts only one subnet
}

module "repo" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/gcp/registry?ref=feature/initial_modules_gcp"

  region     = var.region
  project_id = var.project_id
}

module "vpc" {
  source          = "git@github.com:nullplatform/main-terraform-modules.git//modules/gcp/vpc?ref=feature/initial_modules_gcp"
  name            = var.project_id
  project_id      = var.project_id
  region          = var.region
  vpc_cidr_block  = var.vpc_cidr_block
  subnet_cidr_map = var.vpc_subnet_cidrs
  environment     = "main"
}

module "dns" {
  source              = "git@github.com:nullplatform/main-terraform-modules.git//modules/gcp/dns?ref=feature/initial_modules_gcp"
  private_domain_name = "private.${var.domain_name}"
  public_domain_name  = var.domain_name
  network_id          = module.vpc.vpc_id
}

module "bucket" {
  source = "git@github.com:nullplatform/main-terraform-modules.git//modules/gcp/bucket?ref=feature/initial_modules_gcp"
  region = var.region
  name   = var.project_id
}
