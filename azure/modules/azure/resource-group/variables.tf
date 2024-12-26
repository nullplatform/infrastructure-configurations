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

variable "tags" {
  type        = map(string)
  description = "A map of tags to pass over resources"
}
