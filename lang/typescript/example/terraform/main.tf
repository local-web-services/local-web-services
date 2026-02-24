terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_sfn_state_machine" "order_processor" {
  name     = "OrderProcessor"
  role_arn = "arn:aws:iam::000000000000:role/StepFunctionsRole"
  type     = "STANDARD"

  definition = <<EOF
{
  "Comment": "Simple order processor — passes input through as output",
  "StartAt": "ProcessOrder",
  "States": {
    "ProcessOrder": {
      "Type": "Pass",
      "End": true
    }
  }
}
EOF
}
