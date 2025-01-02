variable "location" {
  type        = string
  description = "The location/region where the resource group should be created"
}

variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}

variable "resource_group" {
  type        = string
  description = "The rg where the account and container will be created"
}
