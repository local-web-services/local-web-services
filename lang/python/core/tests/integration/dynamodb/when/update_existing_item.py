"""When: an existing "dynamodb" "item" is updated in the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, TEST_UPDATED_VAL, _store, _try_json


@when('an existing "dynamodb" "item" is updated in the "dynamodb" "table"')
def update_existing_item(client: TestClient, world: dict):
    get_r = DynamodbTestClient(client).post(
        "GetItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    if get_r.status_code != 200 or "Item" not in _try_json(get_r):
        world["result"] = None
        world["error"] = {"message": "Item does not exist; cannot update"}
        return
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
