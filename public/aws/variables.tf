# General variables

variable "domain_name" {
  type = string
  description = "The domain name to use for nullplatform applications"
  default = "nullapps.io"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "organization" {
  type        = string
  description = "The nullplatform organization slug"
  default = "bombo"
}

variable "account" {
  type        = string
  description = "The nullplatform default account slug"
  default = "stage"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
  default     = "default"
}

# AWS variables

variable "region" {
  type    = string
  default = "us-east-2"
  description = "The AWS region to use"
}

variable "vpc" {
  type = map(object)
  description = "A VPC with public and private subnets"
  default = {
    cidr = "172.30.0.0/16"
    private_subnets = ["172.30.0.0/20","172.30.16.0/20","172.30.32.0/20"]
    public_subnets = ["172.30.48.0/20","172.30.64.0/20", "172.30.79.0/20"]
    azs = ["us-east-2a","us-east-2b","us-east-2c"]
  }
}
