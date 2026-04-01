"""Constants and shared helpers for CloudTrail E2E tests."""

from __future__ import annotations

TEST_TRAIL = "e2e-test-trail-1"
TEST_TRAIL_2 = "e2e-test-trail-2"
TEST_BUCKET = "e2e-cloudtrail-bucket-1"
TEST_BUCKET_2 = "e2e-cloudtrail-bucket-2"
TEST_EB_BUS = "e2e-cloudtrail-bus-1"
TEST_EB_BUS_ARN = f"arn:aws:events:us-east-1:123456789012:event-bus/{TEST_EB_BUS}"

TEST_SQS_QUEUE = "e2e-ct-sqs-queue-1"
TEST_S3_BUCKET = "e2e-ct-s3-bucket-1"
TEST_DDB_TABLE = "e2e-ct-ddb-table-1"
TEST_S3_KEY = "e2e-object-key-1"
