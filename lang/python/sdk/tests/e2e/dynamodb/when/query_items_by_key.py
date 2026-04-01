"""When: "dynamodb" "item"s are queried from the "dynamodb" "table" by key"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when('"dynamodb" "item"s are queried from the "dynamodb" "table" by key')
def query_items_by_key(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").query(
            TableName=TEST_TABLE,
            KeyConditionExpression="#pk = :pk",
            ExpressionAttributeNames={"#pk": TEST_PK},
            ExpressionAttributeValues={":pk": {"S": TEST_ITEM_KEY}},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
