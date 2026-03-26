"""When: an item is updated in the table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, TEST_UPDATED_VAL


@when("an item is updated in the table")
def update_item(lws_session, world):
    try:
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
