################################################################################
# General Variables from root module
################################################################################

variable "account" {
  type        = string
  description = "The null platform account slug"
}

################################################################################
# Variables from other Modules
################################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

