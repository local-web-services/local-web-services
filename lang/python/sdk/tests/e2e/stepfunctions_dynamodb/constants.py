"""Constants and shared helpers."""

from __future__ import annotations

import json

TEST_SM = "test-sm-1"

TEST_TABLE = "e2e-test-table-1"

TEST_PK = "id"

TEST_ITEM_KEY = "e2e-item-1"

ROLE_ARN = "arn:aws:iam::000000000000:role/test"

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})

TEST_INPUT = '{"key": "value"}'


def _dynamodb_put_item_definition(table_name: str, pk: str, item_key: str) -> str:
    """Return a state machine definition with a DynamoDB PutItem task."""
    return json.dumps(
        {
            "StartAt": "PutItem",
            "States": {
                "PutItem": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::dynamodb:putItem",
                    "Parameters": {
                        "TableName": table_name,
                        "Item": {pk: {"S": item_key}},
                    },
                    "End": True,
                }
            },
        }
    )


def _dynamodb_get_item_definition(table_name: str, pk: str, item_key: str) -> str:
    """Return a state machine definition with a DynamoDB GetItem task."""
    return json.dumps(
        {
            "StartAt": "GetItem",
            "States": {
                "GetItem": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::dynamodb:getItem",
                    "Parameters": {
                        "TableName": table_name,
                        "Key": {pk: {"S": item_key}},
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
