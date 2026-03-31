"""When: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ATTR_VAL, TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when('a "dynamodb" "item" is conditionally written to the "dynamodb" "table"')
def conditional_write_item(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "PutItem",
        {
            "TableName": TEST_TABLE,
            "Item": {TEST_PK: {"S": TEST_ITEM_KEY}, "data": {"S": TEST_ATTR_VAL}},
            "ConditionExpression": "attribute_not_exists(pk)",
        },
    )
    _store(world, r)
