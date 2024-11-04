variable "location" {
  type        = string
  description = "The location/region where the resources should be created"
  default = "westus2"
}

variable "domain_name" {
  type = string
  description = "The domain name to use for the DNS zone"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "organization" {
  type        = string
  description = "The nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "The nullplatform default account slug"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
  default     = null
}
