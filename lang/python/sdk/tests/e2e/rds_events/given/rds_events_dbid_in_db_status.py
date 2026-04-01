"""Given: dbid in db_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given("dbid in db_status")
def rds_events_dbid_in_db_status(lws_session):
    RdsEventsTestClient(lws_session).create_db_instance()
