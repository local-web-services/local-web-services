"""Then: the item is updated in the table"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, TEST_UPDATED_VAL


@then("the item is updated in the table")
def item_is_updated_then(client: TestClient):
    r = DynamodbTestClient(client).post(
        "GetItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    expected_val = TEST_UPDATED_VAL
    actual_val = r.json().get("Item", {}).get("data", {}).get("S")
    assert (
        actual_val == expected_val
    ), f"Expected item data to be '{expected_val}' but got '{actual_val}'"
