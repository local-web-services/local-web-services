resource "aws_lambda_function" "create_order" {
  function_name    = "CreateOrderFunction"
  role             = aws_iam_role.create_order.arn
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  filename         = "${path.module}/lambda/create-order/bootstrap.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/create-order/bootstrap.zip")

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
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  filename         = "${path.module}/lambda/get-order/bootstrap.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/get-order/bootstrap.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.orders.name
    }
  }
}

resource "aws_lambda_function" "process_order" {
  function_name    = "ProcessOrderFunction"
  role             = aws_iam_role.process_order.arn
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  filename         = "${path.module}/lambda/process-order/bootstrap.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/process-order/bootstrap.zip")

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
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  filename         = "${path.module}/lambda/generate-receipt/bootstrap.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/generate-receipt/bootstrap.zip")

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
