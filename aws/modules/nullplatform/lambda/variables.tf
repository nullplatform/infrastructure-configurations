################################################################################
# General Variables from root module
################################################################################

variable "region" {
  type = string
}

variable "nrn" {
  type        = string
  description = "The null platform nrn"
}

variable "api_key" {
  type        = string
  description = "nullplatform API key"
}

variable "suffix" {
  type        = string
  description = "A suffix for the bucket name"
}

################################################################################
# Variables from other Modules
################################################################################

variable "application_manager_role" {
  type        = string
  description = "The ARN of the null-application-role"
}

variable "domain_name" {
  type = string
}

variable "hosted_zone_id" {
  type        = string
  description = "The Hosted zone if for the private dns"
}

variable "hosted_public_zone_id" {
  type        = string
  description = "The Hosted zone if for the public dns"
}

variable "scope_manager_role" {
  type        = string
  description = "Add admin role to the aws-auth configmap"
}

variable "vpc_id" {
  type        = string
  description = "The VPC id used for ec2 and lambda"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids used for ec2 and lambda"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The sg ids used for ec2 and lambda"
}

variable "private_load_balancer_arn" {
  type        = string
  description = "The private alb arn used for ec2 and lambda"
}

variable "private_load_balancer_listener_arn" {
  type        = string
  description = "The private alb listener arn used for ec2 and lambda"
}

variable "public_load_balancer_arn" {
  type        = string
  description = "The private alb arn used for ec2 and lambda"
}

variable "public_load_balancer_listener_arn" {
  type        = string
  description = "The private alb listener arn used for ec2 and lambda"
}

variable "Lambda_function_role_arn" {
  type        = string
  description = "The S3 bucket name where assets for Lambda are uploaded"
}



