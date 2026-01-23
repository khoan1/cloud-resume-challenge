# ACM Certificate for the domain and www subdomain
resource "aws_acm_certificate" "tf_cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "crc-tf-cert"
    Environment = var.environment
  }
}

# DNS Validation Records for ACM Certificate
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.tf_cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.tf_domain.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# ACM Certificate Validation
# Waits for ACM to validate the certificate via DNS
# Without this, dependent resources (e.g. CloudFront) may fail because
# the certificate is still in PENDING_VALIDATION state
resource "aws_acm_certificate_validation" "tf_cert" {
  certificate_arn = aws_acm_certificate.tf_cert.arn
  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation : record.fqdn
  ]
}


