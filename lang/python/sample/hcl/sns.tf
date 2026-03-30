resource "aws_sns_topic" "order_notifications" {
  name = "order-notifications"
}

resource "aws_sqs_queue" "notification_queue" {
  name = "order-notification-queue"
}

resource "aws_sns_topic_subscription" "order_notifications_sqs" {
  topic_arn = aws_sns_topic.order_notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notification_queue.arn
}
