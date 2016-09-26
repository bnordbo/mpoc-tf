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
