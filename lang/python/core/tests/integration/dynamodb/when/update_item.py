"""When: an item is updated in the table"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, TEST_UPDATED_VAL, _store


@when("an item is updated in the table")
def update_item(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "UpdateItem",
        {
            "TableName": TEST_TABLE,
            "Key": {TEST_PK: {"S": TEST_ITEM_KEY}},
            "UpdateExpression": "SET #d = :val",
            "ExpressionAttributeNames": {"#d": "data"},
            "ExpressionAttributeValues": {":val": {"S": TEST_UPDATED_VAL}},
        },
    )
    _store(world, r)
