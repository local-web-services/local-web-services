resource "aws_secretsmanager_secret" "notification_api_key" {
  name        = "orders/notification-api-key"
  description = "API key for the notification service"
}

resource "aws_secretsmanager_secret_version" "notification_api_key" {
  secret_id = aws_secretsmanager_secret.notification_api_key.id
  secret_string = jsonencode({
    apiKey = "local-dev-key-12345"
  })
}
