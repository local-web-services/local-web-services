"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the table already exists")
def table_already_exists(client: TestClient):
    DynamodbTestClient(client).create_table()
