################################################################################
# General Variables from root module
################################################################################

variable "region" {
  type = string
}

variable "account" {
  type = string
  description = "The null platform account slug"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

################################################################################
# Variables from other Modules
################################################################################

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "application_manager_role" {
  type        = string
  description = "The ARN of the null-application-role"
}

variable "scope_manager_role" {
  type        = string
  description = "Add admin role to the aws-auth configmap"
}

variable "telemetry_manager_role" {
  type        = string
  description = "Add admin role to the aws-auth configmap"
}

variable "build_workflow_user_access_key_id" {
  type        = string
  description = "The access key ID for the null-build-workflow-user"
}

variable "build_workflow_user_secret_access_key" {
  type        = string
  description = "The secret access key for the null-build-workflow-user"
}

