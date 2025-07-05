provider "aws" {
  region = "sa-east-1"
}

# Read your OpenAPI spec file
data "local_file" "openapi_spec" {
  filename = "${path.module}/api-specification.yaml"
}

resource "aws_api_gateway_rest_api" "my_api" {
  name = "terraformado-api"

  # Import the openapi spec body as a string
  body = data.local_file.openapi_spec.content
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_rest_api.my_api]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
}

resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
