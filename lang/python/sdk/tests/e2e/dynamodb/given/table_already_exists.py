"""Given: the "dynamodb" "table" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('the "dynamodb" "table" already existed')
def table_already_exists(lws_session):
    DynamodbTestClient(lws_session).create_table()
