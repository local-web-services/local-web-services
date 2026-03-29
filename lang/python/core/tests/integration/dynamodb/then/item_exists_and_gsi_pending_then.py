"""Then: the item exists in the table and "GSI" propagation is pending"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then('the item exists in the table and "GSI" propagation is pending')
def item_exists_and_gsi_pending_then(client: TestClient):
    r = DynamodbTestClient(client).post(
        "GetItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    actual_item = r.json().get("Item")
    assert actual_item, f"Expected item with key '{TEST_ITEM_KEY}' to exist in table"
