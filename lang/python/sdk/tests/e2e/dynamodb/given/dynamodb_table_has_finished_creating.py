"""Given: a "dynamodb" "table" finishes creating and becomes active"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given('a "dynamodb" "table" finishes creating and becomes active')
def dynamodb_table_has_finished_creating(lws_session):
    DynamodbTestClient(lws_session).create_table()
