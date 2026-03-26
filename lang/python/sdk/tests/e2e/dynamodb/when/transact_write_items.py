"""When: a transactional write is initiated across one or more items"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@when("a transactional write is initiated across one or more items")
def transact_write_items(lws_session, world):
    try:
        world["result"] = DynamodbTestClient(lws_session).transact_write_items(
            TransactItems=[
                {
                    "Put": {
                        "TableName": TEST_TABLE,
                        "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
                    }
                }
            ]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
