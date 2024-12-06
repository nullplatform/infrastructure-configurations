resource "aws_acm_certificate" "cert" {
  provider          = aws
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.account}.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    organization = var.organization
    account      = var.account
    name         = "${var.domain_name} Certificate"
  }
}

# DNS validation records
resource "aws_route53_record" "cert_validation" {
  provider = aws
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }
  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
