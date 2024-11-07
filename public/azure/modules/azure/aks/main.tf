module "aks" {
  source                            = "Azure/aks/azurerm"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  prefix                            = var.organization
  cluster_name                      = var.cluster_name
  kubernetes_version                = "1.30.4"
  vnet_subnet_id                    = var.vnet_subnet_id
  api_server_authorized_ip_ranges   = var.authorized_ip_ranges
  private_cluster_enabled           = false
  role_based_access_control_enabled = true
  rbac_aad                          = false
  agents_size                       = "Standard_A2_v2"
  net_profile_service_cidr          = "10.1.0.0/16"
  net_profile_dns_service_ip        = "10.1.0.10"
  node_pools = {
    cluster_node_pool = {
      name                        = "nodepool"
      vm_size                     = "Standard_DS2_v2"
      enable_auto_scaling         = true
      min_count                   = 1
      max_count                   = 10
      node_count                  = 2
      availability_zones          = ["1", "2", "3"]
      vnet_subnet_id              = var.vnet_subnet_id
      temporary_name_for_rotation = "temporarynodepool"
    }
  }
  tags = {
    organization = var.organization
    account      = var.account
  }
}
