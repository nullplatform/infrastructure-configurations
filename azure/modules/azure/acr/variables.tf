variable "application_name" {
  description = "The Demo application name."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name to create the registry."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "sku" {
  default     = "Basic"
  description = "The Tier."
  type        = string
}