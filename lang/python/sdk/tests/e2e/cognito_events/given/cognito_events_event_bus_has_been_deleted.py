"""Given: the EventBridge event bus has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient
from ..constants import TEST_BUS


@given("the EventBridge event bus has been deleted")
def cognito_events_event_bus_has_been_deleted(lws_session):
    CognitoEventsTestClient(lws_session).create_bus()
    CognitoEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
