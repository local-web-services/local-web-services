"""Given: the EventBridge event bus is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient
from ..constants import TEST_BUS


@given("the EventBridge event bus is deleted")
def eventbridge_bus_deleted_seq(lws_session):
    try:
        NeptuneEventsTestClient(lws_session).create_bus()
    except Exception:
        pass
    NeptuneEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
