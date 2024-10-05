locals {
  hosted_zone = "nullapps.io"
}

data "aws_route53_zone" "nullappsio" {
  name         = local.hosted_zone
  private_zone = false
}

resource "aws_route53_record" "delegation" {
  zone_id = data.aws_route53_zone.nullappsio.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = 300
  records = var.name_servers
}
