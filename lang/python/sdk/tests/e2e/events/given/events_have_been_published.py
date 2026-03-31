"""Given: events are published to an "eventbridge" "bus" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient
from ..constants import TEST_EVENTS_PUBLISHED_BUS, TEST_EVENTS_PUBLISHED_RULE


@given('events are published to an "eventbridge" "bus"')
def events_have_been_published(lws_session):
    EventsTestClient(lws_session).put_target(
        bus_name=TEST_EVENTS_PUBLISHED_BUS, rule_name=TEST_EVENTS_PUBLISHED_RULE
    )
    EventsTestClient(lws_session).put_events(
        Entries=[
            {
                "EventBusName": TEST_EVENTS_PUBLISHED_BUS,
                "Source": "test.source",
                "DetailType": "TestEvent",
                "Detail": '{"key": "value"}',
            }
        ]
    )
