"""Given: events have been published to an event bus"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_BUS


@given("events have been published to an event bus")
def events_have_been_published(lws_session):
    try:
        EventsTestClient(lws_session).create_bus()
    except Exception:
        pass
    EventsTestClient(lws_session).put_events(
        Entries=[
            {
                "EventBusName": TEST_BUS,
                "Source": "test.source",
                "DetailType": "TestEvent",
                "Detail": '{"key": "value"}',
            }
        ]
    )
