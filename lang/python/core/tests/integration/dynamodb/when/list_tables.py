"""When: all tables are listed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import _store


@when("all tables are listed")
def list_tables(client: TestClient, world: dict):
    r = DynamodbTestClient(client).post("ListTables", {})
    _store(world, r)
