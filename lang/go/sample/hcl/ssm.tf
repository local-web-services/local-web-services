resource "aws_ssm_parameter" "max_items" {
  name        = "/orders/config/max-items"
  type        = "String"
  value       = "100"
  description = "Maximum items per order"
}
