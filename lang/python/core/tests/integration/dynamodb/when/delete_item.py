"""When: an item is deleted from the table"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _store


@when("an item is deleted from the table")
def delete_item(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post(
        "DeleteItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
    _store(world, r)
