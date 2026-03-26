"""Constants and shared helpers."""

from __future__ import annotations

TEST_BUCKET = "e2e-test-bucket-1"

TEST_KEY = "e2e-test-key-1"

TEST_TOPIC = "e2e-test-topic-1"

TEST_BODY = b"test-data-content-1"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
