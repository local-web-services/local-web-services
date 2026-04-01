"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_EVENTS_PUBLISHED_BUS = "e2e-events-published-bus-1"

TEST_EVENTS_PUBLISHED_RULE = "e2e-events-published-rule-1"

TEST_RULE = "test-rule-1"

TEST_TARGET_ID = "test-target-1"

TEST_FUNC_NAME = "e2e-events-func-1"

TEST_TARGET_ARN = f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC_NAME}"

LAMBDA_ROLE_ARN = "arn:aws:iam::000000000000:role/test"

EVENT_PATTERN = json.dumps({"source": ["test.source"]})
