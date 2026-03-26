"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_QUEUE = "e2e-test-q1"

TEST_MESSAGE_BODY = "e2e-test-sqs-message-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _sqs_task_definition(queue_name: str) -> str:
    """Return a state machine definition with an SQS sendMessage task."""
    queue_url = f"http://127.0.0.1/000000000000/{queue_name}"
    return json.dumps(
        {
            "StartAt": "SendToSqs",
            "States": {
                "SendToSqs": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::sqs:sendMessage",
                    "Parameters": {
                        "QueueUrl": queue_url,
                        "MessageBody": TEST_MESSAGE_BODY,
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
