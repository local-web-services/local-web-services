"""Constants and shared helpers."""

from __future__ import annotations

TEST_FUNC = "e2e-test-func-1"

TEST_TOPIC_NAME = "e2e-test-topic-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
