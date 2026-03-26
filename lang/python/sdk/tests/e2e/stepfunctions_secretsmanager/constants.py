"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_SECRET = "e2e-test-secret-1"

TEST_SECRET_VALUE = "e2e-test-secret-value-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _secretsmanager_get_secret_definition(secret_id: str) -> str:
    """Return a state machine definition with a SecretsManager getSecretValue task."""
    return json.dumps(
        {
            "StartAt": "GetSecretValue",
            "States": {
                "GetSecretValue": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::secretsmanager:getSecretValue",
                    "Parameters": {
                        "SecretId": secret_id,
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
