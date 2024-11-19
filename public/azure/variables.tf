variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription id to create resources"
}

variable "azure_resource_group_name" {
  type        = string
  description = "Wheter to use this rg or to create one. With null one will be created"
}

variable "azure_vnet" {
  type        = map(any)
  description = "Metadata that a subnet has"
  default     = {}
}

variable "azure_credential" {
  type        = map(any)
  description = "Credentials to configure null cloud provider"
  default     = {}
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant id where the subscription exists"
}

variable "location" {
  type        = string
  description = "The location/region where the resources should be created"
  default     = "westus2"
}

variable "domain_name" {
  type        = string
  description = "The domain name to use for the DNS zone"
  nullable    = true
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "The AKS Cluster name"
  nullable    = true
  default     = null
}

variable "organization" {
  type        = string
  description = "The nullplatform organization slug"
}

variable "organization_id" {
  type        = string
  description = "The nullplatform organization id"
}

variable "account" {
  type        = string
  description = "The nullplatform default account slug"
}

variable "account_id" {
  type        = string
  description = "The nullplatform default account id"
}

variable "np_api_key" {
  type        = string
  description = "the Nullplatform api key"
}

variable "namespace" {
  type        = string
  description = "The default namespace to use for nullplatform applications"
  nullable    = true
  default     = null
}

