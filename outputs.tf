output "api_id" {
  description = "API Gateway ID"
  value       = aws_api_gatewayv2_api.my_api.id
}

output "stage_name" {
  description = "Deployment stage name"
  value       = aws_api_gatewayv2_stage.dev_stage.name
}