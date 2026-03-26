"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

TEST_TARGET_ID = "test-target-1"

TEST_TARGET_ARN = "arn:aws:lambda:us-east-1:000000000000:function:test-func-1"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})
