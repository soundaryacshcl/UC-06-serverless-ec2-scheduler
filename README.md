Overview 

Many companies don't need their EC2 instances running 24/7. This solution automates the process of starting instances at the beginning of the workday (8:00 AM) and stopping them at the end of the workday (5:00 PM), helping to optimize costs while ensuring resources are available when needed. 

Architecture 

The solution uses the following AWS services: 

AWS Lambda: Executes the code to start and stop EC2 instances 

Amazon CloudWatch Events: Schedules Lambda functions based on cron expressions 

AWS IAM: Manages permissions for Lambda functions 

Amazon EC2: The target instances to be managed 

 

Features 

Fully serverless architecture with minimal operational overhead 

Tag-based instance targeting (only manages instances with specific tags) 

Configurable scheduling with CloudWatch Events 

Secure IAM roles with least privilege permissions 

Comprehensive logging for monitoring and troubleshooting 

Infrastructure as Code (IaC) with Terraform for consistent deployments 

CI/CD pipeline with GitHub Actions 

 

GitHub Actions CI/CD 

The repository includes a GitHub Actions workflow for CI/CD: 

Runs on push pull requests to main branch 

Validates Terraform configuration 

Performs security scanning with tflint and Checkov 

Creates a plan and comments on pull requests 

Applies changes when merged to main 
