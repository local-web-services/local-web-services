"""When: an existing "dynamodb" "item" is deleted from the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store, _try_json


@when('an existing "dynamodb" "item" is deleted from the "dynamodb" "table"')
def delete_existing_item(client: TestClient, world: dict):
    get_r = DynamodbTestClient(client).post(
        "GetItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    if get_r.status_code != 200 or "Item" not in _try_json(get_r):
        world["result"] = None
        world["error"] = {"message": "Item does not exist; cannot delete"}
        return
    r = DynamodbTestClient(client).post(
        "DeleteItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    _store(world, r)
