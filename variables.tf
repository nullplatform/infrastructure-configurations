
################################################################################
# Default Variables
################################################################################

variable "region" {
  type    = string
  default = "us-east-2"
}


################################################################################
# EKS Cluster Variables
################################################################################

variable "cluster_name" {
  type    = string
  default = "tf-cluster"
}

################################################################################
# ALB Controller Variables
################################################################################

variable "env_name" {
  type    = string
  default = "dev"
}

################################################################################
# Route53 Variables
################################################################################

variable "domain_name" {
  type    = string
}

################################################################################
# Nullplatform Variables
################################################################################

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
