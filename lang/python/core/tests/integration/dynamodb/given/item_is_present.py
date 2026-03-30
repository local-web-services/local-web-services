"""Given: the item is present"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the item is present")
def item_is_present(client: TestClient):
    DynamodbTestClient(client).put_item()
