"""Given: an item has been conditionally written to the table"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("an item has been conditionally written to the table")
def dynamodb_item_conditionally_written(lws_session):
    DynamodbTestClient(lws_session).create_table()
