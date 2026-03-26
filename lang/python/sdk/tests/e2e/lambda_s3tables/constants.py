"""Constants and shared helpers."""

from __future__ import annotations

TEST_FUNC = "e2e-test-func-1"

TEST_BUCKET = "e2e-test-table-bucket-1"

TEST_NAMESPACE = "e2e-test-namespace-1"

TEST_TABLE = "e2e-test-table-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _table_bucket_arn(name=TEST_BUCKET):
    return f"arn:aws:s3tables:us-east-1:000000000000:bucket/{name}"
