"""Given: the "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('the "dynamodb" "table" existed')
def table_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
