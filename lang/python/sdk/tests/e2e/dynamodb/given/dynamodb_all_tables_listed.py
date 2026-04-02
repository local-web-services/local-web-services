"""Given: all "dynamodb" "table"s are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('all "dynamodb" "table"s are listed')
def dynamodb_all_tables_listed(lws_session):
    DynamodbTestClient(lws_session).create_table()
