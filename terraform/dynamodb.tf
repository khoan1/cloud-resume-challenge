# DynamoDB table for page view counter
resource "aws_dynamodb_table" "page_views" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "crc-dynamodb-page-views"
    Environment = var.environment
  }
}
