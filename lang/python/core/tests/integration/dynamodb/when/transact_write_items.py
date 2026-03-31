"""When: a transactional write is initiated across one or more items in a "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when('a transactional write is initiated across one or more items in a "dynamodb" "table"')
def transact_write_items(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "TransactWriteItems",
        {
            "TransactItems": [
                {
                    "Put": {
                        "TableName": TEST_TABLE,
                        "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
                    }
                }
            ]
        },
    )
    _store(world, r)
