variable "account" {
  type        = string
  description = "The null platform account slug."
}

variable "cluster_name" {
  type        = string
  description = "The AKS Cluster name."
}

variable "resource_group_name" {
  type        = string
  description = "The Azure resource group name."
}

variable "subscription_id" {
  type        = string
  description = "The Azure subscription Id."
}
