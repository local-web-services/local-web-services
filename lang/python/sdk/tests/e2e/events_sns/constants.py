"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

TEST_TOPIC = "e2e-test-topic-1"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})

TEST_MESSAGE = "test-sns-message-1"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
