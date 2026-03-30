"""Constants and shared helpers."""

from __future__ import annotations

TEST_TOPIC = "e2e-test-topic-1"

TEST_QUEUE = "e2e-test-q1"

TEST_MESSAGE = "test-message-body-1"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"
