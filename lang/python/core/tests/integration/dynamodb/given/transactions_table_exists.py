"""Given: the transaction's "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given('the transaction\'s "dynamodb" "table" existed')
def transactions_table_exists(client: TestClient):
    DynamodbTestClient(client).create_table()
