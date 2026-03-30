"""Constants and shared helpers."""

from __future__ import annotations

TEST_API = "e2e-test-api-1"

TEST_TOPIC_NAME = "e2e-test-topic-1"

_REGION = "us-east-1"

_ACCOUNT = "000000000000"

_STAGE = "prod"


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:{_REGION}:{_ACCOUNT}:{name}"
