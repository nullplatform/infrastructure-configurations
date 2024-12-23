################################################################################
# General Variables from root module
################################################################################

variable "nrn" {
  type        = string
  description = "The null platform nrn"
}

################################################################################
# Variables from other Modules
################################################################################

variable "github_organization" {
  type        = string
  description = "The github organization to associate to nullplatform."
}

variable "github_organization_installation_id" {
  type        = string
  description = "The github installation id after installing the organization to Nullplatform github application."
}
