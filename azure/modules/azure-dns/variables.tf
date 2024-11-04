variable "resource_group" {
  type        = string
  description = "The name of the resource group"
}

variable "domain_name" {
  type = string
  description = "The domain name to use for the DNS zone"
}

variable "virtual_network_id" {
  type = string
  description = "The ID of the virtual network to link the private DNS zone to"
}
