output "api_url" {
  description = "HTTP API Gateway URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "queue_url" {
  description = "Order Queue URL"
  value       = aws_sqs_queue.order_queue.url
}

output "topic_arn" {
  description = "Notification Topic ARN"
  value       = aws_sns_topic.order_notifications.arn
}
