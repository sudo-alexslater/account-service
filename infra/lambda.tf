///////////////////////////////////////////////////////////////
// Healthcheck
///////////////////////////////////////////////////////////////
module "healthcheck" {
  source    = "git@github.com:sudo-alexslater/terraform-modules.git//lambda?ref=main"
  name      = "healthcheck"
  code_path = "${path.root}/../core/dist/healthcheck.js"
  prefix    = local.prefix
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
// List Accounts
///////////////////////////////////////////////////////////////
module "list_accounts" {
  source    = "git@github.com:sudo-alexslater/terraform-modules.git//lambda?ref=main"
  name      = "list-accounts"
  code_path = "${path.root}/../core/dist/list-accounts.js"
  prefix    = local.prefix
  environment_variables = {
    LOBBY_TABLE_NAME = aws_dynamodb_table.accounts.name
  }
}
resource "aws_lambda_permission" "apigw_invoke_list_accounts" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.list_accounts.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.core.execution_arn}/*/*"
}
resource "aws_iam_role_policy_attachment" "list_accounts_dynamo" {
  role       = module.list_accounts.role_name
  policy_arn = aws_iam_policy.account_dynamo_policy.arn
}

///////////////////////////////////////////////////////////////
// Create Account
///////////////////////////////////////////////////////////////
module "create_account" {
  source    = "git@github.com:sudo-alexslater/terraform-modules.git//lambda?ref=main"
  name      = "create-account"
  code_path = "${path.root}/../core/dist/create-account.js"
  prefix    = local.prefix
  environment_variables = {
    LOBBY_TABLE_NAME = aws_dynamodb_table.accounts.name
  }
}
resource "aws_lambda_permission" "apigw_invoke_create_account" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.create_account.name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.core.execution_arn}/*/*"
}
resource "aws_iam_role_policy_attachment" "create_account_dynamo" {
  role       = module.create_account.role_name
  policy_arn = aws_iam_policy.account_dynamo_policy.arn
}
