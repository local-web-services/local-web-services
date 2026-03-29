"""Given: the item exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the item exists")
def item_exists(client: TestClient):
    DynamodbTestClient(client).put_item()
