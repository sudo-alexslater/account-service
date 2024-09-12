///////////////////////////////////////////////////////////////
// Healthcheck
///////////////////////////////////////////////////////////////
module "healthcheck" {
  source = "./modules/lambda"
  name   = "healthcheck"
  prefix = local.prefix
}
resource "aws_lambda_permission" "apigw_invoke_healthcheck" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.healthcheck.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.core.execution_arn}/*/*"
}

///////////////////////////////////////////////////////////////
// List Customers
///////////////////////////////////////////////////////////////
module "list_customers" {
  source = "./modules/lambda"
  name   = "list-customers"
  prefix = local.prefix
  environment_variables = {
    LOBBY_TABLE_NAME = aws_dynamodb_table.customers.name
  }
}
resource "aws_lambda_permission" "apigw_invoke_list_customers" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.list_customers.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.core.execution_arn}/*/*"
}
resource "aws_iam_role_policy_attachment" "list_customers_dynamo" {
  role       = module.list_customers.role_name
  policy_arn = aws_iam_policy.customer_dynamo_policy.arn
}

///////////////////////////////////////////////////////////////
// Create Customer
///////////////////////////////////////////////////////////////
module "create_customer" {
  source = "./modules/lambda"
  name   = "create-customer"
  prefix = local.prefix
  environment_variables = {
    LOBBY_TABLE_NAME = aws_dynamodb_table.customers.name
  }
}
resource "aws_lambda_permission" "apigw_invoke_create_customer" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.create_customer.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.core.execution_arn}/*/*"
}
resource "aws_iam_role_policy_attachment" "create_customer_dynamo" {
  role       = module.create_customer.role_name
  policy_arn = aws_iam_policy.customer_dynamo_policy.arn
}
