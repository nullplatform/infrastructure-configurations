module "my_apps" {
  for_each = var.application_names

  source = "./modules/azure/acr"

  application_name    = each.key
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}
