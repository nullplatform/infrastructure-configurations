provider "azurerm" {
  subscription_id = "c1678f88-e6e7-4ae4-9a88-24f53fa99d23"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

provider "helm" {
  alias = "aks"
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

provider "nullplatform" {
  np_apikey = "MTUxNDkzNDYxNg==.ZzQkUi0xWnFzRFh3aDdhOGZxQGFnSjk0NEEtS0dNWk8="
  api_key = "MTUxNDkzNDYxNg==.ZzQkUi0xWnFzRFh3aDdhOGZxQGFnSjk0NEEtS0dNWk8="
  alias = "default"
}

