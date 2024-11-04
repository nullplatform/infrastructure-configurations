variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster and network will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
  default     = "eastus"
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "authorized_ip_ranges" {
  description = "IP ranges that are allowed to access the Kubernetes API server."
  type        = list(string)
  default     = ["52.44.34.101/32", "52.203.144.244/32"]
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed."
  type        = string
}

variable "organization" {
  description = "The organization name or identifier."
  type        = string
}

variable "account" {
  description = "The account identifier for tagging."
  type        = string
}
