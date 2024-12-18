# General variables

variable "domain_name" {
  type        = string
  description = "The domain name to use for nullplatform applications"
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

variable "nrn" {
  type        = string
  description = "The NRN to register providers"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
}

# AWS variables
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
    cidr            = "172.31.0.0/16"
    private_subnets = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
    public_subnets  = ["172.31.48.0/20", "172.31.64.0/20", "172.31.80.0/20"]
    azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}
