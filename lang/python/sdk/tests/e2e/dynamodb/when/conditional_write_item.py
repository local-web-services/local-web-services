"""When: an item is conditionally written to the table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when("an item is conditionally written to the table")
def conditional_write_item(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).put_item(
            TableName=TEST_TABLE,
            Item={TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
            ConditionExpression="attribute_not_exists(pk)",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
