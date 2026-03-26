"""Given: tid in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("tid in table_status")
def events_ddb_tid_in_table_status(lws_session):
    EventsDynamodbTestClient(lws_session).create_table()
