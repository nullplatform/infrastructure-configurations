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

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

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

variable "telemetry_manager_role" {
  type        = string
  description = "Add admin role to the aws-auth configmap"
}

variable "build_workflow_user_access_key_id" {
  type        = string
  description = "The access key ID for the null-build-workflow-user"
}

variable "build_workflow_user_secret_access_key" {
  type        = string
  description = "The secret access key for the null-build-workflow-user"
}

variable "ec2_instance_profile" {
  type        = string
  description = "The IAM Instance profile to attach to EC2 instances"
}

variable "ec2_ssh_key_name" {
  type        = string
  description = "SSH key name used to attach to EC2 instances"
  default     = null
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI Id used to launch to EC2 instances"
  default     = "ami-0a6dd292b2a2a778c" #null-runtime-58 
}

variable "ec2_parameters_bucket" {
  type        = string
  description = "The parameters bucket storage"
}

variable "ec2_parameters_encryption_secret" {
  type        = string
  description = "The parameters bucket storage encryption key"
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

variable "lambda_assets_bucket" {
  type        = string
  description = "The S3 bucket name where assets for Lambda are uploaded"
}

variable "Lambda_function_role_arn" {
  type        = string
  description = "The S3 bucket name where assets for Lambda are uploaded"
}



