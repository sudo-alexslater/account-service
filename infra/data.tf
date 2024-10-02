data "aws_vpc" "main" {
  tags = {
    Name = "sandbox-base-vpc"
  }
}
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    SubnetType = "private"
  }
}
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    SubnetType = "public"
  }
}
data "aws_cognito_user_pools" "core_auth_pool" {
  name = "sandbox-base-core-auth-pool"
}


data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "this" {}
data "aws_region" "this" {}
