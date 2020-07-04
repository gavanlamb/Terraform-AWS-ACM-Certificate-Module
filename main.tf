locals {
  default_tags = {
    Company = var.company
    Environment = var.environment
    Name = var.name
    Service = var.service
    ManagedBy = "Terraform"
  }
}

provider "aws" {}

resource "aws_acm_certificate" "cert" {
  domain_name = var.domain_name
  validation_method = "DNS"

  tags = merge(local.default_tags, var.tags)
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "cert_validation_record" {
  name = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  allow_overwrite = var.allow_overwrite
  records = [
    aws_acm_certificate.cert.domain_validation_options[0].resource_record_value
  ]
  zone_id = var.zone_id
  ttl = var.record_ttl
}
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation_record.fqdn
  ]
}
