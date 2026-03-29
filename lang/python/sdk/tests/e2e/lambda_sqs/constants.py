"""Constants and shared helpers."""

from __future__ import annotations

TEST_FUNC = "e2e-test-func-1"

TEST_QUEUE = "e2e-test-q1"

TEST_DLQ = "e2e-test-dlq-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"
