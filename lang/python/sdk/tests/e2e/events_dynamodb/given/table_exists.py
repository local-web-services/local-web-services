"""Given: the table exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("the table exists")
def table_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
