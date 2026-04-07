"""Given: multiple "dynamodb" "item"s with different attribute values existed in the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DynamodbTestClient


@given(
    'multiple "dynamodb" "item"s with different attribute values existed in the "dynamodb" "table"'
)
def items_with_different_attribute_values(client: TestClient):
    DynamodbTestClient(client).put_items_with_different_statuses()
