"""Given: multiple "dynamodb" "item"s with different attribute values existed in the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given(
    'multiple "dynamodb" "item"s with different attribute values existed in the "dynamodb" "table"'
)
def items_with_different_attribute_values(lws_session):
    DynamodbTestClient(lws_session).put_items_with_different_statuses()
