"""Given: name in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("name in table_status")
def dynamodb_name_in_table_status(lws_session):
    DynamodbTestClient(lws_session).create_table()
