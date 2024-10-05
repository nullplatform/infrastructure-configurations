variable "location" {
  type        = string
  description = "The location/region where the resource group should be created"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group"
}

variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}
