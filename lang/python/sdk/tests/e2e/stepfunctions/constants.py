"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_SM_EXPRESS = "test-sm-express-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

UPDATED_DEFINITION = json.dumps(
    {"StartAt": "PassV2", "States": {"PassV2": {"Type": "Pass", "End": True}}}
)

TEST_TAG_KEY = "e2e-test-tag-key-1"

TEST_TAG_VALUE = "test-tag-value-1"

TEST_INPUT = '{"key": "value"}'


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
