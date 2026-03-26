"""Given: a table has finished creating and become active"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("a table has finished creating and become active")
def dynamodb_table_has_finished_creating(lws_session):
    DynamodbTestClient(lws_session).create_table()
