variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID which Load balancers will be deployed in"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN used for IRSA"
  type        = string
}

variable "suffix" {
  type        = string
  description = "A suffix for the bucket name"
}
