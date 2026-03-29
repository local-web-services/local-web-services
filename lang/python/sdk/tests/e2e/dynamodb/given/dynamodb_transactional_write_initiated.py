"""Given: a transactional write has been initiated across one or more items"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DynamodbTestClient


@given("a transactional write has been initiated across one or more items")
def dynamodb_transactional_write_initiated(lws_session):
    DynamodbTestClient(lws_session).create_table()
