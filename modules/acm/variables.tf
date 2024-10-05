################################################################################
# General Variables from root module
################################################################################

variable "region" {
  type    = string
}

################################################################################
# Variables from other Modules
################################################################################

variable "zone_id" {
  description = "Route53 Zone ID where certificate will be validated"
  type        = string
}

################################################################################
# Variables defined using Environment Variables
################################################################################

variable "domain_name" {
  type    = string
}
