################################################################################
# General Variables from root module
################################################################################

variable "account" {
  type        = string
  description = "The null platform account slug"
}

variable "nrn" {
  type        = string
  description = "The null platformnrn"
}

variable "env" {
  type        = string
  description = "The environment dimension name that applies to all configurations"
  default     = null
}

################################################################################
# Variables from other Modules
################################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "domain_name" {
  type        = string
  description = "The domain name used for this organization"
}

/*
Azure Vars
*/

variable "azure_client_id" {
  type        = string
  description = "Azure credential id."
}

variable "azure_client_secret" {
  type        = string
  description = "Azure credential secret (password)."
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription id."
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure tenant id."
}

variable "azure_resource_group_id" {
  type        = string
  description = "Azure Resource group where the managed DNS hosted zone was created"
}
