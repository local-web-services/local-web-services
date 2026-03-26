"""Given: a table has been described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("a table has been described")
def dynamodb_table_has_been_described(lws_session):
    DynamodbTestClient(lws_session).create_table()
