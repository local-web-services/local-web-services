"""Given: all tables are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("all tables are listed")
def dynamodb_all_tables_listed(lws_session):
    DynamodbTestClient(lws_session).create_table()
