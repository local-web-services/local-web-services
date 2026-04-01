"""Given: the transaction's "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('the transaction\'s "dynamodb" "table" existed')
def transactions_table_exists(lws_session):
    DynamodbTestClient(lws_session).create_table()
