resource "aws_s3_bucket" "receipts" {
  bucket        = "order-receipts-${var.aws_account_id}-${var.aws_region}"
  force_destroy = true
}
