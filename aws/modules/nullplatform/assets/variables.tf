################################################################################
# General Variables from root module
################################################################################

variable "region" {
  type = string
}

variable "nrn" {
  type        = string
  description = "The null platform nrn"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "domain_name" {
  type = string
}

################################################################################
# Variables from other Modules
################################################################################

variable "application_manager_role" {
  type        = string
  description = "The ARN of the null-application-role"
}

variable "build_workflow_user_access_key_id" {
  type        = string
  description = "The access key ID for the null-build-workflow-user"
}

variable "build_workflow_user_secret_access_key" {
  type        = string
  description = "The secret access key for the null-build-workflow-user"
}

variable "lambda_assets_bucket" {
  type        = string
  description = "The S3 bucket name where assets for Lambda are uploaded"
}

variable "scope_manager_role" {
  type        = string
  description = "Add admin role to the aws-auth configmap"
}

variable "hosted_zone_id" {
  type        = string
  description = "The Hosted zone if for the private dns"
}

variable "hosted_public_zone_id" {
  type        = string
  description = "The Hosted zone if for the public dns"
}

