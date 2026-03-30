"""Given: the item is not present"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE


@given("the item is not present")
def item_is_not_present(client: TestClient):
    DynamodbTestClient(client).post(
        "DeleteItem", {"TableName": TEST_TABLE, "Key": {TEST_PK: {"S": TEST_ITEM_KEY}}}
    )
