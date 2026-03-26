"""Given: the item is not present"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@given("the item is not present")
def item_is_not_present(lws_session):
    """Delete the item to ensure it is not present in the table."""
    try:
        DynamodbTestClient(lws_session).delete_item(
            TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}}
        )
    except Exception:
        pass
