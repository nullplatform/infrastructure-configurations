# Public Hosted Zone
resource "aws_route53_zone" "public_zone" {
  name = var.domain_name

  tags = {
    Name = "${var.domain_name} - Public Zone"
  }
}

# Private Hosted Zone
resource "aws_route53_zone" "private_zone" {
  name = var.domain_name
  vpc {
    vpc_id = var.vpc_id
    vpc_region = var.region
  }

  tags = {
    Name = "${var.domain_name} - Private Zone"
  }
}
