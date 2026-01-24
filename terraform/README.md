# Terraform

This folder contains Terraform files used to build and manage the website infrastructure on AWS.

- acm.tf: Manages the ACM SSL certificate used for the custom domain.

- apigateway.tf: Creates the API Gateway used to expose the Lambda function for the visitor counter.

- cloudfront.tf: Configures the CloudFront distribution used to deliver the website content.

- dynamodb.tf: Creates the DynamoDB table used to store the website visitor count.

- function.zip: Contains the packaged AWS Lambda function code for the visitor counter.

- iam.tf: Defines IAM roles and permissions required for the Lambda function.

- lambda.tf: Deploys the AWS Lambda function used for the visitor counter.

- providers.tf: Configures the AWS provider used by Terraform.

- route53.tf: Manages DNS records for the custom domain using Route 53.

- s3.tf: Creates the S3 bucket used to host the static website files.

- terraform.tfvars: Stores variable values used during Terraform deployment.

- variables.tf: Defines input variables used across the Terraform configuration.
