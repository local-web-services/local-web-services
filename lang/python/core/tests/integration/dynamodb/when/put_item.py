"""When: a "dynamodb" "item" is written to the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when('a "dynamodb" "item" is written to the "dynamodb" "table"')
def put_item(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "PutItem",
        {
            "TableName": TEST_TABLE,
            "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
        },
    )
    _store(world, r)
