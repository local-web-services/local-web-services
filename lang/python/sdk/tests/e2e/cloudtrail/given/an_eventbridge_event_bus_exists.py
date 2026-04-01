"""Given: an EventBridge event bus exists"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_EB_BUS


@given("an EventBridge event bus exists")
def an_eventbridge_event_bus_exists(lws_session):
    events = lws_session.client("events")
    try:
        events.create_event_bus(Name=TEST_EB_BUS)
    except Exception:
        pass
