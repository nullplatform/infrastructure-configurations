# General variables

variable "domain_name" {
  type        = string
  description = "The domain name to use for nullplatform applications"
  default     = "<<MY_ORG>>.nullapps.io"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "organization" {
  type        = string
  description = "The nullplatform organization slug"
  default     = "<<MY_ORG>>"
}

variable "account" {
  type        = string
  description = "The nullplatform default account slug"
  default     = "<<MY_ACCOUNT>>"
}

variable "nrn" {
  type        = string
  description = "The NRN to register providers"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
  default     = "default"
}

# AWS variables

variable "region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region to use"
}

variable "vpc_stg" {
  description = "A VPC with public and private subnets"
  default = {
    cidr            = "172.30.0.0/16"
    private_subnets = ["172.30.0.0/20", "172.30.16.0/20", "172.30.32.0/20"]
    public_subnets  = ["172.30.48.0/20", "172.30.64.0/20", "172.30.80.0/20"]
    azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}

variable "vpc_production" {
  description = "A VPC with public and private subnets"
  default = {
    cidr            = "172.30.0.0/16"
    private_subnets = ["172.30.0.0/20", "172.30.16.0/20", "172.30.32.0/20"]
    public_subnets  = ["172.30.48.0/20", "172.30.64.0/20", "172.30.80.0/20"]
    azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
}
