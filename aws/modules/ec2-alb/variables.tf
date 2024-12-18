variable "certificate_arn" {
  type        = string
  description = "The certificate arn to use with the LB"
}

variable "vpc_id" {
  type        = string
  description = "The VPC id where the load balancer will be deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC cidr used for the whole setup"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids to associate to the LB"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids to associate to the LB"
}

variable "suffix" {
  type        = string
  description = "A suffix for the bucket name"
}

