variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}

variable "vpc" {
  type        = map(object)
  description = "A VPC with public and private subnets"
}
