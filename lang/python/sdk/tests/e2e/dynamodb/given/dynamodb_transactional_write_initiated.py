"""Given: a transactional write is initiated across one or more items in a "dynamodb" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('a transactional write is initiated across one or more items in a "dynamodb" "table"')
def dynamodb_transactional_write_initiated(lws_session):
    DynamodbTestClient(lws_session).create_table()
