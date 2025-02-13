provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = module.gke.cluster_endpoint
  cluster_ca_certificate = module.gke.cluster_ca_certificate
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = module.gke.cluster_endpoint
    cluster_ca_certificate = module.gke.cluster_ca_certificate
    token                  = data.google_client_config.default.access_token
  }
}

provider "nullplatform" {
  api_key = var.api_key
}
