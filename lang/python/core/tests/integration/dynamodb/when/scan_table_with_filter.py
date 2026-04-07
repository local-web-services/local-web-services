"""When: all "dynamodb" "item"s in the "dynamodb" "table" are scanned with a filter expression"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE, _store


@when('all "dynamodb" "item"s in the "dynamodb" "table" are scanned with a filter expression')
def scan_table_with_filter(client: TestClient, world: dict):
    r = DynamodbTestClient(client).scan_with_filter(TEST_TABLE)
    _store(world, r)
