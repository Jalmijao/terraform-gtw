provider "aws" {
  region = "sa-east-1"
}

data "local_file" "openapi_spec" {
  filename = "${path.module}/api-specification.yaml"
}

resource "aws_api_gateway_rest_api" "my_api" {
  name = "terraformado-api"
  body = data.local_file.openapi_spec.content
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id

  triggers = {
    redeploy = sha1(data.local_file.openapi_spec.content)
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_rest_api.my_api
  ]
}

resource "aws_api_gateway_stage" "prod_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
