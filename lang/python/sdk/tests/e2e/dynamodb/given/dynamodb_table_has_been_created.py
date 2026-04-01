"""Given: a table has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("a table has been created")
def dynamodb_table_has_been_created(lws_session):
    DynamodbTestClient(lws_session).create_table()
