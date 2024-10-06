variable "cloud_provider" {
  type = string
  description = "The cloud provider to use (aws, azure, or gcp)"
  default = "aws"
}

variable "domain_name" {
  type = string
  description = "The domain name to use for nullplatform applications"
  default = "nullapps.io"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}
