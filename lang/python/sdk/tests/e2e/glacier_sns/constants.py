"""Constants and shared helpers."""

from __future__ import annotations

TEST_TOPIC_NAME = "e2e-test-topic-1"

TEST_VAULT = "e2e-test-vault-1"


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
