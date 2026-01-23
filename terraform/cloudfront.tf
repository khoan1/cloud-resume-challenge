# CloudFront OAC for CRC Resume Site
resource "aws_cloudfront_origin_access_control" "resume_oac" {
  name                              = "crc-resume-oac"
  description                       = "OAC for CRC resume site"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "resume_cdn" {
  depends_on = [
    aws_acm_certificate_validation.tf_cert
  ]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  # S3 Origin for Resume Site
  origin {
    domain_name              = aws_s3_bucket.resume_site.bucket_regional_domain_name
    origin_id                = "s3-resume-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.resume_oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-resume-origin"
    viewer_protocol_policy = "redirect-to-https"

    # Cache all content without query strings or cookies
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = [
    var.domain_name,
    "www.${var.domain_name}"
  ]

  # Use ACM certificate for custom domain
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.tf_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name        = "crc-cloudfront"
    Environment = var.environment
  }
}
