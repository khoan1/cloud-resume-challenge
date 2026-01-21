# Hosted zone for the domain (allen-nguyen-resume.com)
# Hosted zone for the subdomain (tf.allen-nguyen-resume.com)
resource "aws_route53_zone" "tf_subdomain" { # "tf_domain"
  name = var.domain_name

  tags = {
    Name        = "crc-tf-domain"
    Environment = var.environment
  }
}

# Route53 A Record Alias to CloudFront Distribution
resource "aws_route53_record" "root_alias" {
  zone_id = aws_route53_zone.tf_domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.resume_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.resume_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# Route53 A Record Alias for www subdomain to CloudFront Distribution
resource "aws_route53_record" "www_alias" {
  zone_id = aws_route53_zone.tf_domain.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.resume_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.resume_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

# Output the nameservers for the subdomain hosted zone
# Will need to copy these into the parent domain’s DNS as NS records
# This step is not needed if this is the root domain
output "tf_domain_nameservers" {
  description = "Nameservers to delegate tf.example.com from parent domain"
  value       = aws_route53_zone.tf_domain.name_servers
}





