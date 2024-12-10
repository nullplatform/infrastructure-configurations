variable "vpcs" {
  description = "VPC ID which the hosted zone should be associated with"
  type = map(object({
    vpc_id     = string
    vpc_region = string
  }))
}

variable "domain_name" {
  type = string
}

variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}
