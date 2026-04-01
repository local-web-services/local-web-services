"""When: a "dynamodb" "table" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE, _store


@when('a "dynamodb" "table" is deleted')
def delete_table(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post("DeleteTable", {"TableName": TEST_TABLE})
    _store(world, r)
