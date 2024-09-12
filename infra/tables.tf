
resource "aws_dynamodb_table" "customers" {
  name         = "${local.prefix}-customers"
  hash_key     = "customerId"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "customerId"
    type = "S"
  }
}
resource "aws_iam_policy" "customer_dynamo_policy" {
  name        = "${local.prefix}-customer-dynamo-policy"
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
      "Resource": "${aws_dynamodb_table.customers.arn}"
    }
  ]
}
EOF
}
