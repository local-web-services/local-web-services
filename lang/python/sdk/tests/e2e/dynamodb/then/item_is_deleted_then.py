"""Then: the item is deleted from the table"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the item is deleted from the table")
def item_is_deleted_then(lws_session):
    client = lws_session.client("dynamodb")
    resp = client.get_item(TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}})
    assert not resp.get("Item"), f"Expected item with key '{TEST_ITEM_KEY}' to be deleted"
