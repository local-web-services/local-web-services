"""Constants and shared helpers."""

from __future__ import annotations

TEST_TABLE = "e2e-test-table-1"

TEST_FUNC = "e2e-test-func-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

_DYNAMODB_ARN_BASE = "arn:aws:dynamodb:us-east-1:000000000000:table"

FUNCTION_ARN_PREFIX = "arn:aws:lambda:us-east-1:000000000000:function"


def _stream_arn(table_name=TEST_TABLE):
    return f"{_DYNAMODB_ARN_BASE}/{table_name}/stream/2024-01-01T00:00:00.000"
