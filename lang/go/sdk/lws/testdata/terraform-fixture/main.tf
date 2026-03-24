resource "aws_dynamodb_table" "test_table" {
  name     = "TfTestTable"
  hash_key = "pk"

  attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_sqs_queue" "test_queue" {
  name = "TfTestQueue"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "tf-test-bucket"
}

resource "aws_sns_topic" "test_topic" {
  name = "TfTestTopic"
}

resource "aws_sfn_state_machine" "test_sm" {
  name     = "TfTestStateMachine"
  role_arn = "arn:aws:iam::000000000000:role/StepFunctionsRole"

  definition = <<EOT
{"StartAt":"Done","States":{"Done":{"Type":"Pass","End":true}}}
EOT
}

resource "aws_ssm_parameter" "test_param" {
  name  = "/tf/test/param"
  type  = "String"
  value = ""
}

resource "aws_secretsmanager_secret" "test_secret" {
  name = "tf-test-secret"
}
