"""When: an existing item is updated in the table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, TEST_UPDATED_VAL


@when("an existing item is updated in the table")
def update_existing_item(lws_session, world):
    try:
        existing = DynamodbTestClient(lws_session).get_item(
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
                "UpdateItem",
            )
        world["result"] = DynamodbTestClient(lws_session).update_item(
            TableName=TEST_TABLE,
            Key={TEST_PK: {"S": TEST_ITEM_KEY}},
            UpdateExpression="SET #d = :val",
            ExpressionAttributeNames={"#d": "data"},
            ExpressionAttributeValues={":val": {"S": TEST_UPDATED_VAL}},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
