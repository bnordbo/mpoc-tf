provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_dynamodb_table" "pockets" {
  name           = "Pockets"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "UserId"
  range_key      = "Name"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "fragments" {
  name           = "Fragments"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "UserId"
  range_key      = "FragmentId"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "FragmentId"
    type = "S"
  }
}

## Development access to AWS resources.

resource "aws_iam_user" "mpoc_api" {
    name = "mpoc-api"
    path = "/systems/"
}

resource "aws_iam_access_key" "mpoc_api" {
    user = "${aws_iam_user.mpoc_api.name}"
}

resource "aws_iam_user_policy" "mpoc_api" {
    name = "test"
    user = "${aws_iam_user.mpoc_api.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:GetRecords",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_dynamodb_table.pockets.arn}",
        "${aws_dynamodb_table.fragments.arn}"
      ]
    }
  ]
}
EOF
}