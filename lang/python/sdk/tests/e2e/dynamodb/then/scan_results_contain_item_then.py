"""Then: the scan results contain the item"""

from __future__ import annotations

from pytest_bdd import then

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the scan results contain the item")
def scan_results_contain_item_then(lws_session):
    client = DynamodbTestClient(lws_session).dynamo()
    resp = client.scan(TableName=TEST_TABLE)
    items = resp.get("Items", [])
    found = any(i.get(TEST_PK, {}).get("S") == TEST_ITEM_KEY for i in items)
    assert found, f"Expected item '{TEST_ITEM_KEY}' in scan results but not found"
