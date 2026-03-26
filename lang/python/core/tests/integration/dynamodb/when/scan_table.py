"""When: all items in the table are scanned"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE, _store


@when("all items in the table are scanned")
def scan_table(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post("Scan", {"TableName": TEST_TABLE})
    _store(world, r)
