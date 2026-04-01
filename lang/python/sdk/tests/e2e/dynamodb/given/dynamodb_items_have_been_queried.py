"""Given: items have been queried from the table by key"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("items have been queried from the table by key")
def dynamodb_items_have_been_queried(lws_session):
    DynamodbTestClient(lws_session).create_table()
    DynamodbTestClient(lws_session).put_item()
