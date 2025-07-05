output "api_id" {
  description = "API Gateway ID"
  value       = aws_api_gateway_rest_api.my_api.id
}