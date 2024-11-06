variable "domain_name" {
  type        = string
  description = "The domain name to use for the DNS zone"
}

variable "organization" {
  type        = string
  description = "The organization slug"
}

variable "name_servers" {
  type        = list(string)
  description = "A list of the name servers for the delegation"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to use"
}
