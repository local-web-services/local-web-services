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


TEST_STATUS_ATTR = "status"

TEST_INITIAL_STATUS = "pending"

TEST_UPDATED_STATUS = "processed"


def _dynamodb_update_item_definition(
    table_name: str, pk: str, item_key: str, attr: str, updated_val: str
) -> str:
    """Return a state machine definition with a DynamoDB UpdateItem task."""
    return json.dumps(
        {
            "StartAt": "UpdateItem",
            "States": {
                "UpdateItem": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::dynamodb:updateItem",
                    "Parameters": {
                        "TableName": table_name,
                        "Key": {pk: {"S": item_key}},
                        "UpdateExpression": "SET #a = :val",
                        "ExpressionAttributeNames": {"#a": attr},
                        "ExpressionAttributeValues": {":val": {"S": updated_val}},
                    },
                    "End": True,
                }
            },
        }
    )


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
