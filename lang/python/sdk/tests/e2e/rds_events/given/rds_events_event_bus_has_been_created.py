"""Given: an EventBridge event bus is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given("an EventBridge event bus is created")
def rds_events_event_bus_has_been_created(lws_session):
    RdsEventsTestClient(lws_session).create_bus()
