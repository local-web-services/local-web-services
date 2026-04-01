"""Given: an EventBridge event bus is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CognitoEventsTestClient


@given("an EventBridge event bus is created")
def cognito_events_event_bus_has_been_created(lws_session):
    CognitoEventsTestClient(lws_session).create_bus()
