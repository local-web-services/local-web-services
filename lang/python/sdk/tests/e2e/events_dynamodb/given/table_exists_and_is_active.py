"""Given: the bus existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('the "dynamodb" "table" existed and was "ACTIVE"')
def table_exists_and_is_active(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
