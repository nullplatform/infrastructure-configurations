variable "region" {
  type    = string
  default = "us-east-2"
}

variable "cluster_name" {
  type    = string
  default = "nullplatform-cluster"
}

variable "domain_name" {
  type = string
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
