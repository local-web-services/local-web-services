"""Given: the "dynamodb" "GSI" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given('the "dynamodb" "GSI" existed')
def gsi_existed(client: TestClient):
    # Arrange + Act: create a GSI-enabled table and put a test item so the GSI is populated
    c = DynamodbTestClient(client)
    c.create_gsi_table()
    c.put_gsi_item()
