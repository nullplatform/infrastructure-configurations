variable "client_id" {
  description = "The aks identity provider to manage Azure DNS records used for validation."
  type        = string
}

variable "domain_name" {
  description = "The hosted zone domain name."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name of the hosted zone."
  type        = string
}

variable "subscription_id" {
  description = "The subscription id of the hosted zone."
  type        = string
}
