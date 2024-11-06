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
}

variable "account" {
  type        = string
  description = "The nullplatform default account slug"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
  default     = null
}

# AWS variables

variable "region" {
  type    = string
  default = "us-east-1"
  description = "The AWS region to use"
}

# Azure variables

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID to use"
  default     = ""
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The location/region where the resources should be created"
}
