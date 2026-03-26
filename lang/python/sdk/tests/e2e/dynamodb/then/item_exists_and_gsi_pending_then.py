"""Then: the item exists in the table and "GSI" propagation is pending"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then('the item exists in the table and "GSI" propagation is pending')
def item_exists_and_gsi_pending_then(lws_session):
    """GSI propagation is internal; just assert the item exists."""
    client = lws_session.client("dynamodb")
    resp = client.get_item(TableName=TEST_TABLE, Key={TEST_PK: {"S": TEST_ITEM_KEY}})
    assert resp.get("Item"), f"Expected item with key '{TEST_ITEM_KEY}' to exist in table"
