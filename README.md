# EC2 Instance Scheduler

Many companies don't need their EC2 instances running 24/7. This solution automates the process of starting instances at the beginning of the workday (8:00 AM) and stopping them at the end of the workday (5:00 PM), helping to optimize costs while ensuring resources are available when needed.

---

## Architecture

This solution is built using:

- **AWS Lambda**  
  Executes the code to start and stop EC2 instances.

- **Amazon CloudWatch Events**  
  Schedules Lambda functions based on cron expressions.

- **AWS IAM**  
  Manages least‑privilege permissions for the Lambda functions.

- **Amazon EC2**  
  The target instances to be managed (tag‑based targeting).

---

## Features

- **Fully serverless**  
  Minimal operational overhead.

- **Tag‑based instance targeting**  
  Only manages the instances with a specific tag (e.g. `Scheduler=true`).

- **Configurable scheduling**  
  Start/stop times configurable via CloudWatch Events cron expressions.

- **Least‑privilege IAM roles**  
  Only the necessary EC2 permissions granted to each Lambda function.

- **Comprehensive logging**  
  Logs all start/stop operations for troubleshooting.

- **Infrastructure as Code (IaC)**  
  Terraform modules define all AWS resources for repeatable deployments.

- **CI/CD pipeline with GitHub Actions**  
  Automates Terraform validation, planning, and apply.

---

## Usage

1. **Tag your instances**  
   ```bash
   aws ec2 create-tags \
     --resources i-1234567890abcdef0 \
     --tags Key=Scheduler,Value=true

2. **Deploy with Terraform**
   ```bash
  git clone https://github.com/your-org/ec2-instance-scheduler.git
  cd ec2-instance-scheduler
  terraform init
  terraform plan -var="tag_key=Scheduler" -var="tag_value=true"
  terraform apply -var="tag_key=Scheduler" -var="tag_value=true"
  
3. **Verify schedules**
   In the AWS Console under CloudWatch → Rules, verify two rules:
   start-instances-workday-8am
   stop-instances-workday-5pm

4. **Check logs**
    Lambda logs in CloudWatch Logs under /aws/lambda/<function-name>.

