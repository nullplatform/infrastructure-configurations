variable "cloudwatch_enabled" {
  type = bool
  description = "Enable Cloudwatch logging"
  default = true
}

variable "tls_secret_name" {
  type = string
  description = "Secret name for TLS"
  default = "www-tls"
}
