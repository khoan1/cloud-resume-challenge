# Backend

This folder contains backend files used for the website visitor counter functionality.

- visit_counter.py: Contains the AWS Lambda function code used to update and retrieve the website visitor count stored in DynamoDB.

- bucket_policy.json: Contains the S3 bucket policy used to allow secure access between the frontend and backend components.

The visitor counter functionality is implemented using AWS Lambda, DynamoDB, and API Gateway, allowing the website to track and display the total number of visits.
