variable "resource_group" {
  type        = string
  description = "The name of the resource group"
}

variable "domain_name" {
  type        = string
  description = "The domain name to use for the DNS zone"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to pass over resources"
}
