"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_API = "e2e-test-api-1"

TEST_SM = "test-sm-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

_REGION = "us-east-1"

_ACCOUNT = "000000000000"

_STAGE = "prod"


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:{_REGION}:{_ACCOUNT}:stateMachine:{name}"
