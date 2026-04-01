"""Given: an EventBridge event bus is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given("an EventBridge event bus is created")
def secretsmanager_events_event_bus_has_been_created(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_bus()
