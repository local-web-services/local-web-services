"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_FUNC = "e2e-test-func-1"

TEST_SM = "test-sm-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
