"""Given: the transaction's table exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the transaction's table exists")
def transactions_table_exists(client: TestClient):
    DynamodbTestClient(client).create_table()
