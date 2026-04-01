"""When: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when('an existing "dynamodb" "item" is deleted from the "dynamodb" "table"')
def delete_existing_item(lws_session, world):
    try:
        existing = lws_session.client("dynamodb").get_item(
            TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
        )
        if "Item" not in existing:
            raise ClientError(
                {
                    "Error": {
                        "Code": "ConditionalCheckFailedException",
                        "Message": "Item does not exist",
                    }
                },
                "DeleteItem",
            )
        world["result"] = lws_session.client("dynamodb").delete_item(
            TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
