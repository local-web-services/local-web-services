"""Given: an existing item has been updated in the table"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("an existing item has been updated in the table")
def dynamodb_existing_item_has_been_updated(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).put_item()
