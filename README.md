# Cloud Resume Challenge
Main website URL:
https://allen-nguyen-resume.com/

This Cloud Resume Challenge website contains information about my IT experience, education, certifications, and projects.

The website content is built using HTML, JavaScript, and CSS, and is hosted on AWS S3. A custom domain is configured using AWS Route 53.
The visitor counter functionality is implemented using AWS Lambda, DynamoDB, and API Gateway.

The entire website infrastructure was also re-built using Infrastructure as Code (IaC) with Terraform.


Repository Structure

- backend: Contains files for the website visitor counter functionality.

- frontend: Contains files for all website styling, layout, and navigation functionality.

- terraform: Contains modular Terraform files used to rebuild the entire site infrastructure from scratch.

- .github/workflows: Contains deploy.yml, which handles CI/CD by deploying website updates from GitHub to AWS.
