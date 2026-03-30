"""When: an item is read from the table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when("an item is read from the table")
def get_item(lws_session, world):
    try:
        DynamodbTestClient(lws_session).put_item()
    except Exception:
        pass
    try:
        world["result"] = DynamodbTestClient(lws_session).get_item(
            TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
