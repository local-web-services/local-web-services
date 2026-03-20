resource "aws_sqs_queue" "order_dlq" {
  name = "order-dlq"
}

resource "aws_sqs_queue" "order_queue" {
  name = "order-queue"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.order_dlq.arn
    maxReceiveCount     = 3
  })
}
