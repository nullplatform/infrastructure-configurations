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

variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}

variable "assets_bucket_arns" {
  type        = list(string)
  description = "Assets bucket arn"
}
variable "parameters_bucket_arns" {
  type        = list(string)
  description = "Parameters bucket arn"
}
variable "parameters_encryption_arns" {
  type        = list(string)
  description = "Parameters secret arn"
}
