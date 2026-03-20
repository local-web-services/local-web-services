data "archive_file" "create_order" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/create-order"
  output_path = "${path.module}/.terraform-build/create-order.zip"
}

data "archive_file" "get_order" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/get-order"
  output_path = "${path.module}/.terraform-build/get-order.zip"
}

data "archive_file" "process_order" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/process-order"
  output_path = "${path.module}/.terraform-build/process-order.zip"
}

data "archive_file" "generate_receipt" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/generate-receipt"
  output_path = "${path.module}/.terraform-build/generate-receipt.zip"
}

resource "aws_lambda_function" "create_order" {
  function_name    = "CreateOrderFunction"
  role             = aws_iam_role.create_order.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.create_order.output_path
  source_code_hash = data.archive_file.create_order.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.orders.name
      QUEUE_URL  = aws_sqs_queue.order_queue.url
    }
  }
}

resource "aws_lambda_function" "get_order" {
  function_name    = "GetOrderFunction"
  role             = aws_iam_role.get_order.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.get_order.output_path
  source_code_hash = data.archive_file.get_order.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.orders.name
    }
  }
}

resource "aws_lambda_function" "process_order" {
  function_name    = "ProcessOrderFunction"
  role             = aws_iam_role.process_order.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.process_order.output_path
  source_code_hash = data.archive_file.process_order.output_base64sha256

  environment {
    variables = {
      TABLE_NAME              = aws_dynamodb_table.orders.name
      TOPIC_ARN               = aws_sns_topic.order_notifications.arn
      BUCKET_NAME             = aws_s3_bucket.receipts.id
      MAX_ITEMS_PARAM         = aws_ssm_parameter.max_items.name
      NOTIFICATION_SECRET_ARN = aws_secretsmanager_secret.notification_api_key.arn
    }
  }
}

resource "aws_lambda_function" "generate_receipt" {
  function_name    = "GenerateReceiptFunction"
  role             = aws_iam_role.generate_receipt.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.generate_receipt.output_path
  source_code_hash = data.archive_file.generate_receipt.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.receipts.id
    }
  }
}

# SQS Event Source Mapping for ProcessOrderFunction
resource "aws_lambda_event_source_mapping" "process_order_sqs" {
  event_source_arn = aws_sqs_queue.order_queue.arn
  function_name    = aws_lambda_function.process_order.arn
  batch_size       = 10
}
