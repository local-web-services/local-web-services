"""Constants and shared helpers."""

from __future__ import annotations

import json

INT_SM = "int-sm-1"

INT_SM_EXPRESS = "int-sm-express-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/int-test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

UPDATED_DEFINITION = json.dumps(
    {"StartAt": "PassV2", "States": {"PassV2": {"Type": "Pass", "End": True}}}
)

INT_TAG_KEY = "int-test-tag-key-1"

INT_TAG_VALUE = "int-test-tag-value-1"

INT_INPUT = '{"key": "value"}'

_SFN_TARGET = "AWSStepFunctions"


def _sm_arn(name: str = INT_SM) -> str:
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _exec_arn(sm_name: str, exec_name: str) -> str:
    return f"arn:aws:states:us-east-1:000000000000:execution:{sm_name}:{exec_name}"
