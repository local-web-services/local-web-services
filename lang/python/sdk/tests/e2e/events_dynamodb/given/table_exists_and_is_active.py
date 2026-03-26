"""Given: the table exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('the table exists and is "ACTIVE"')
def table_exists_and_is_active(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
