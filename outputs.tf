output "start_lambda_function_name" {
  value = module.lambda_start.this.function_name 
}

output "stop_lambda_function_name" {
  value = module.lambda_stop.this.function_name
}

output "start_event_rule" {
  value = module.start_schedule.event_rule_name
}

output "stop_event_rule" {
  value = module.stop_schedule.event_rule_name
}
