# Create S3 bucket for resume site
resource "aws_s3_bucket" "resume_site" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "crc-resume-site"
    Environment = var.environment
  }
}

# Configure public access block to enhance security
resource "aws_s3_bucket_public_access_block" "resume_site" {
  bucket = aws_s3_bucket.resume_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Set ownership controls to prefer bucket owner
resource "aws_s3_bucket_ownership_controls" "resume_site" {
  bucket = aws_s3_bucket.resume_site.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "resume_site" {
  bucket = aws_s3_bucket.resume_site.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Policy to allow CloudFront access via OAC
resource "aws_s3_bucket_policy" "resume_site" {
  bucket = aws_s3_bucket.resume_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.resume_site.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.resume_cdn.arn
          }
        }
      }
    ]
  })
}


