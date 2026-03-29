"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_BUS = "e2e-test-bus-1"

TEST_RULE = "test-rule-1"

TEST_SM = "test-sm-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

EVENT_PATTERN = json.dumps({"source": ["test.source"]})

TEST_INPUT = '{"key": "value"}'


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
