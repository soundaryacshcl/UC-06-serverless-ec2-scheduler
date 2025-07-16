module "iam" {
  source = "./modules/iam"
  name   = "ec2_scheduler_lambda"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function/ec2_control.py"
  output_path = "${path.module}/lambda_function/ec2_control.zip"
}

module "lambda_stop" {
  source         = "./modules/lambda"
  lambda_zip     = data.archive_file.lambda_zip.output_path
  function_name  = "ec2-stop-lambda"
  handler        = "ec2_control.lambda_handler"
  role_arn       = module.iam.role_arn
  instance_ids   = var.ec2_instance_ids
  ec2_action     = "stop"
}

module "lambda_start" {
  source         = "./modules/lambda"
  lambda_zip     = data.archive_file.lambda_zip.output_path
  function_name  = "ec2-start-lambda"
  handler        = "ec2_control.lambda_handler"
  role_arn       = module.iam.role_arn
  instance_ids   = var.ec2_instance_ids
  ec2_action     = "start"
}

module "stop_schedule" {
  source          = "./modules/eventbridge"
  name            = "stop-ec2-schedule"
#  cron_expression = "cron(0 17 ? * MON-FRI *)" # trigger at 5:00 PM IST every Monday, Tuesday, Wednesday, Thursday, and Friday. 
  cron_expression = "cron(0/2 * * * ? *)"  #a schedule that triggers a job at the 0th second of every even-numbered minute (0, 2, 4, 6, ..., 58) within every hour, every day, every month, and every day of the week.
  lambda_arn      = module.lambda_stop.this.arn
  lambda_name     = module.lambda_stop.this.function_name
}

module "start_schedule" {
  source          = "./modules/eventbridge"
  name            = "start-ec2-schedule"
#  cron_expression = "cron(0 8 ? * MON-FRI *)" # trigger at 8:00 AM IST every Monday, Tuesday, Wednesday, Thursday, and Friday.
  cron_expression = "cron(0/3 * * * ? *)"    # the task will run at 0, 3, 6, 9... minutes past every hour.
  lambda_arn      = module.lambda_start.this.arn
  lambda_name     = module.lambda_start.this.function_name
}


