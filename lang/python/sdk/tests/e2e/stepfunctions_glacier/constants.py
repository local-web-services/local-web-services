"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_VAULT = "e2e-test-vault-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
