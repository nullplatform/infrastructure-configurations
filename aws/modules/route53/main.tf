resource "aws_route53_zone" "public_zone" {
  name     = var.domain_name
  provider = aws
  tags = {
    name         = "${var.domain_name} - Public Zone"
    organization = var.organization
    account      = var.account
  }
}

resource "aws_route53_zone" "private_zone" {
  name     = var.domain_name
  provider = aws

  dynamic "vpc" {
    for_each = var.vpcs
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = {
    name         = "${var.domain_name} - Private Zone"
    organization = var.organization
    account      = var.account
  }
}
