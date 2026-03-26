"""Given: the item exists in the table"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the item exists in the table")
def item_exists_in_table(client: TestClient):
    DynamodbTestClient(client).put_item()
