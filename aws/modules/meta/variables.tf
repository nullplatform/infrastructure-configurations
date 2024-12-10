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

variable "suffix" {
  type        = string
  description = "A suffix for the bucket name"
}

# Null

variable "nullplatform_role_arn" {
  type        = string
  description = "nullplatform role arn for ec2 and lambda"
}

variable "nullplatform_scope_workflow_role_arn" {
  type        = string
  description = "nullplatform role arn for managing scopes"
}

variable "nullplatform_telemetry_manager_role_arn" {
  type        = string
  description = "nullplatform role arn for managing telemtry providers"
}

variable "nullplatform_instance_profile_arn" {
  type        = string
  description = "nullplatform instance profile role arn for ec2 and lambda"
}

variable "nullplatform_build_workflow_user_secret_access_key" {
  type        = string
  description = "nullplatform build user for configured CI"
}

variable "nullplatform_build_workflow_user_access_key_id" {
  type        = string
  description = "nullplatform build user for configured CI"
}

variable "nullplatform_application_role_arn" {
  type        = string
  description = "nullplatform application role arn"
}

variable "nullplatform_dimensions" {
  type        = list(string)
  description = "This value hooks up the module to the dimensions created"
}

# AWS variables

variable "vpc" {
  description = "A VPC with public and private subnets"
}

variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "hosted_zone_id" {
  type        = string
  description = "The AWS private hosted zone id"
}
variable "hosted_public_zone_id" {
  type        = string
  description = "The AWS public hosted zone id"
}

variable "parameters_encryption" {
  type        = string
  description = "The secret manager key to decrypt values"
}
