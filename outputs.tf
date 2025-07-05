output "api_id" {
  description = "API Gateway ID"
  value       = aws_api_gateway_rest_api.my_api.id
}

output "stage_name" {
  description = "Deployment stage name"
  value       = aws_api_gateway_stage.dev_stage.name
}