"""Then: the scan results contain the item"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the scan results contain the item")
def scan_results_contain_item_then(client: TestClient):
    r = DynamodbTestClient(client).post("Scan", {"TableName": TEST_TABLE})
    actual_items = r.json().get("Items", [])
    actual_found = any(i.get(TEST_PK, {}).get("S") == TEST_ITEM_KEY for i in actual_items)
    assert actual_found, f"Expected item '{TEST_ITEM_KEY}' in scan results but not found"
