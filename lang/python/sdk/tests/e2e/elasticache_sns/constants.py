"""Constants and shared helpers."""

from __future__ import annotations

TEST_CLUSTER = "e2e-test-cluster-1"

TEST_TOPIC = "e2e-test-topic-1"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
