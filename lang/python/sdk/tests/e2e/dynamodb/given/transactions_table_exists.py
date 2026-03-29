"""Given: the transaction's table exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("the transaction's table exists")
def transactions_table_exists(lws_session):
    DynamodbTestClient(lws_session).create_table()
