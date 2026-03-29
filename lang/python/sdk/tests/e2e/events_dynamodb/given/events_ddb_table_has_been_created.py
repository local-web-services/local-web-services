"""Given: a DynamoDB table has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("a DynamoDB table has been created")
def events_ddb_table_has_been_created(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
