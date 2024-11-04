provider "azurerm" {
  subscription_id = "4f01781f-c243-43cd-bf9a-5532f6379f9d"
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

