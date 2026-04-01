"""Then: the query results contain the item"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@then("the query results contain the item")
def query_results_contain_item_then(client: TestClient):
    r = DynamodbTestClient(client).post(
        "Query",
        {
            "TableName": TEST_TABLE,
            "KeyConditionExpression": "#pk = :pk",
            "ExpressionAttributeNames": {"#pk": TEST_PK},
            "ExpressionAttributeValues": {":pk": {"S": TEST_ITEM_KEY}},
        },
    )
    actual_count = r.json().get("Count", 0)
    assert actual_count >= 1, "Expected at least one item in query results"
