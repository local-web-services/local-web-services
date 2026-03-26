"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_TOPIC = "e2e-test-topic-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _sns_task_definition(topic_name: str) -> str:
    """Return a state machine definition with an SNS publish task."""
    topic_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
    return json.dumps(
        {
            "StartAt": "PublishToSns",
            "States": {
                "PublishToSns": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::sns:publish",
                    "Parameters": {
                        "TopicArn": topic_arn,
                        "Message": "test-message",
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"
