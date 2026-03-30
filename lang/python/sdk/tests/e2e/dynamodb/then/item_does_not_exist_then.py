"""Then: the item does not exist in the table"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the item does not exist in the table")
def item_does_not_exist_then(lws_session):
    client = lws_session.client("dynamodb")
    resp = client.get_item(TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}})
    assert not resp.get("Item"), f"Expected item with key '{TEST_ITEM_KEY}' to not exist in table"
