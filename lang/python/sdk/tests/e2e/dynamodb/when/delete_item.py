"""When: an item is deleted from the table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when("an item is deleted from the table")
def delete_item(lws_session, world):
    try:
        world["result"] = lws_session.client("dynamodb").delete_item(
            TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
