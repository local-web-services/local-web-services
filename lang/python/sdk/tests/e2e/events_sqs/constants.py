"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

TEST_QUEUE = "e2e-test-q1"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})

TEST_MESSAGE = "test-message-body-1"


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"
