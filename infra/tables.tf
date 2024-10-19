
resource "aws_dynamodb_table" "accounts" {
  name         = "${local.prefix}-accounts"
  hash_key     = "accountId"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "accountId"
    type = "S"
  }
}
resource "aws_iam_policy" "account_dynamo_policy" {
  name        = "${local.prefix}-account-dynamo-policy"
  description = "Policy for Lambda to access DynamoDB"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "${aws_dynamodb_table.accounts.arn}"
    }
  ]
}
EOF
}
