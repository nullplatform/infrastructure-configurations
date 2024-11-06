variable "account" {
  type        = string
  description = "The null platform account slug"
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name to create the registry."
  type        = string
}

variable "sku" {
  default     = "Basic"
  description = "The Tier."
  type        = string
}

variable "token_password_expiry" {
  default     = null
  description = "The token password 1 expiration date of the password in RFC3339 format."
  type        = string
}

variable "token_name" {
  type        = string
  description = "The token name used by nullplatform to push images to the ACR."
  default     = "nullplatform"
}
