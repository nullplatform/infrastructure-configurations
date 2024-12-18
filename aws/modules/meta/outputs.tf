# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The subnet ids used for ec2 and lambda"
  value       = module.vpc.private_subnets
}

output "security_group_ids" {
  description = "The sg ids used for ec2 and lambda"
  value       = module.alb.security_group_ids
}

output "private_load_balancer_arn" {
  description = "The private alb arn used for ec2 and lambda"
  value       = module.alb.private_load_balancer_arn
}

output "private_load_balancer_listener_arn" {
  description = "The private alb listener arn used for ec2 and lambda"
  value       = module.alb.private_load_balancer_listener_arn
}

output "public_load_balancer_arn" {
  description = "The private alb arn used for ec2 and lambda"
  value       = module.alb.public_load_balancer_arn
}

output "public_load_balancer_listener_arn" {
  description = "The private alb listener arn used for ec2 and lambda"
  value       = module.alb.public_load_balancer_listener_arn
}

