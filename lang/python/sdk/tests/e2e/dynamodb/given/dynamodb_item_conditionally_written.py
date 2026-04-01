"""Given: a "dynamodb" "item" is conditionally written to the "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('a "dynamodb" "item" is conditionally written to the "dynamodb" "table"')
def dynamodb_item_conditionally_written(lws_session):
    DynamodbTestClient(lws_session).create_table()
