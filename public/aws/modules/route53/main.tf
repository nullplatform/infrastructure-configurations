resource "aws_route53_zone" "public_zone" {
  name = var.domain_name
  provider = aws
  tags = {
    name = "${var.domain_name} - Public Zone"
    organization = var.organization
    account = var.account
  }
}

data "aws_region" "current" {
  provider = aws
}

resource "aws_route53_zone" "private_zone" {
  name = var.domain_name
  provider = aws
  vpc {
    vpc_id = var.vpc_id
    vpc_region = data.aws_region.current.name
  }
  tags = {
    name = "${var.domain_name} - Private Zone"
    organization = var.organization
    account = var.account
  }
}
