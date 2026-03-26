"""When: items are queried from the table by key"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when("items are queried from the table by key")
def query_items_by_key(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "Query",
        {
            "TableName": TEST_TABLE,
            "KeyConditionExpression": "#pk = :pk",
            "ExpressionAttributeNames": {"#pk": TEST_PK},
            "ExpressionAttributeValues": {":pk": {"S": TEST_ITEM_KEY}},
        },
    )
    _store(world, r)
