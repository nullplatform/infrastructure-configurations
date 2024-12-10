resource "nullplatform_provider_config" "network" {
  provider   = nullplatform
  nrn        = var.nrn
  type       = "aws-networking-configuration"
  dimensions = {}
  attributes = jsonencode({
    "vpc" : {
      "id" : var.vpc_id,
      "subnets" : var.subnet_ids,
      "security_groups" : var.security_group_ids
    },
    "load_balancer" : {
      "private" : {
        "arn" : var.private_load_balancer_arn,
        "listener_arn" : var.private_load_balancer_listener_arn
      },
      "public" : {
        "arn" : var.public_load_balancer_arn,
        "listener_arn" : var.public_load_balancer_listener_arn
      }
    }
  })
}
