# Lambda Function to Update Page View Counter in DynamoDB
resource "aws_lambda_function" "page_counter" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"

  # Path to your zipped Lambda function code
  filename = "${path.module}/lambda/function.zip"
  # Check if the code has changed
  source_code_hash = filebase64sha256("${path.module}/lambda/function.zip")

  # Environment variable to pass DynamoDB table name
  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }
}
