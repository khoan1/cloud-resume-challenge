import json     # Importing json module for handling JSON data
import boto3    # Importing AWS SDK for Python (Boto3) to interact with AWS services

# Initialize a DynamoDB resource and specify the table name
dynamodb = boto3.resource("dynamodb")

# Reference to the DynamoDB table
table = dynamodb.Table("visitCounter")

# Lambda function handler
def lambda_handler(event, context):
    # Update the visit count atomically
    response = table.update_item(
        Key={"id": "visits"},   # Primary key to identify the item
        UpdateExpression="ADD #count :inc", # Increment the count attribute by 1
        # Using expression attribute names and values to avoid reserved words
        ExpressionAttributeNames={
            "#count": "count"
        },
        # Value to increment the count by
        ExpressionAttributeValues={
            ":inc": 1
        },
        ReturnValues="UPDATED_NEW"  # Return the updated attributes
    )

    # Return the updated count in the response
    return {
        "statusCode": 200,  # HTTP status code for success
        # Response headers indicating JSON content type
        "headers": {
            "Content-Type": "application/json"
        },
        # Response body with the updated count
        "body": json.dumps({
            "count": int(response["Attributes"]["count"])
        })
    }
