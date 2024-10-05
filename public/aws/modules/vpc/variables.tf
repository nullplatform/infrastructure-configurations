variable "organization" {
  type        = string
  description = "nullplatform organization slug"
}

variable "account" {
  type        = string
  description = "nullplatform default account slug"
}

variable "vpc" {
  description = "A VPC with public and private subnets"
}
