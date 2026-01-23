# -------------------------
# General / Environment
# -------------------------
variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Deployment environment (dev, prod)"
  type        = string
  default     = "dev"
}

# -------------------------
# Domain / Frontend
# -------------------------
variable "domain_name" {
  description = "Primary domain name (allen-nguyen-resume.com)"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for the resume website"
  type        = string
}

# -------------------------
# Backend
# -------------------------
variable "dynamodb_table_name" {
  description = "DynamoDB table for page view counter"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name for visitor counter"
  type        = string
}
