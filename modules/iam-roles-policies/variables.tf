################################################################################
# General Variables from root module
################################################################################

variable "region" {
  type    = string
}

variable "scope_manager_assume_role" {
  type    = string
  default = "arn:aws:iam::283477532906:role/scope_and_deploy_manager"
}

variable "telemetry_manager_assume_role" {
  type    = string
  default = "arn:aws:iam::283477532906:role/telemetry_manager"
}

variable "application_manager_assume_role" {
  type    = string
  default = "arn:aws:iam::283477532906:role/application_manager"
}
