"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_PARAM = "/e2e/test/param/1"

TEST_VALUE = "test-value-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _ssm_get_parameter_definition(param_name: str) -> str:
    """Return a state machine definition with an SSM getParameter task."""
    return json.dumps(
        {
            "StartAt": "GetParameter",
            "States": {
                "GetParameter": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::ssm:getParameter",
                    "Parameters": {
                        "Name": param_name,
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
