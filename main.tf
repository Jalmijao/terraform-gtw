terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_apigatewayv2_api" "my_api" {
  name          = "SampleAPI"
  protocol_type = "HTTP"

  body = file("${path.module}/api-specification.yaml")
}

resource "aws_api_gateway_stage" "dev_stage" {
  api_id      = aws_api_gatewayv2_api.my_api.id
  name        = "dev"
  auto_deploy = true
}

output "api_endpoint" {
  description = "Invoke URL of the API Gateway"
  value       = aws_api_gatewayv2_api.my_api.api_endpoint
}
