variable "zone_id" {
  description = "Route53 Zone ID where certificate will be validated"
  type        = string
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
