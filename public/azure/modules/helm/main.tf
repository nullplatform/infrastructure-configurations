module "istio" {
  source = "./istio"
}

module "cert-manager" {
  source = "./cert-manager"

  client_id           = var.client_id
  domain_name         = var.domain_name
  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
}
