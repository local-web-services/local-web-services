"""When: a "dynamodb" "item" is read from the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when('a "dynamodb" "item" is read from the "dynamodb" "table"')
def get_item(client: TestClient, world: dict):
    DynamodbTestClient(client).post(
        "PutItem",
        {
            "TableName": TEST_TABLE,
            "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
        },
    )
    r = DynamodbTestClient(client).post(
        "GetItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    _store(world, r)
