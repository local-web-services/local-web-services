"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_BUCKET = "e2e-test-bucket-1"

TEST_KEY = "e2e-test-key-1"

TEST_BODY = b"test-data-content-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _s3_put_object_definition(bucket: str, key: str, body: str) -> str:
    """Return a state machine definition with an S3 putObject task."""
    return json.dumps(
        {
            "StartAt": "PutObject",
            "States": {
                "PutObject": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::s3:putObject",
                    "Parameters": {
                        "Bucket": bucket,
                        "Key": key,
                        "Body": body,
                    },
                    "End": True,
                }
            },
        }
    )


def _s3_get_object_definition(bucket: str, key: str) -> str:
    """Return a state machine definition with an S3 getObject task."""
    return json.dumps(
        {
            "StartAt": "GetObject",
            "States": {
                "GetObject": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::s3:getObject",
                    "Parameters": {
                        "Bucket": bucket,
                        "Key": key,
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
