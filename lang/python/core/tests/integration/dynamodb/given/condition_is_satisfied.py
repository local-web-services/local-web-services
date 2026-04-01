"""Given: the condition is satisfied"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given("the condition is satisfied")
def condition_is_satisfied(client: TestClient):
    DynamodbTestClient(client).put_item()
