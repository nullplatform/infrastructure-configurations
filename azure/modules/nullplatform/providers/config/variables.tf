################################################################################
# General Variables from root module
################################################################################

variable "account" {
  type        = string
  description = "The null platform account slug"
}

################################################################################
# Variables from other Modules
################################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "azure_client_id" {
  type = string
  description = "Azure credential id."  
}

variable "azure_client_secret" {
  type = string
  description = "Azure credential secret (password)."  
}

variable "azure_subscription_id" {
  type = string
  description = "Azure subscription id."  
}

variable "azure_tenant_id" {
  type = string
  description = "Azure tenant id."  
}
