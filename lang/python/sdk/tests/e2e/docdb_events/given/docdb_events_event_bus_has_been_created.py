"""Given: an EventBridge event bus has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbEventsTestClient


@given("an EventBridge event bus has been created")
def docdb_events_event_bus_has_been_created(lws_session):
    DocdbEventsTestClient(lws_session).create_bus()
