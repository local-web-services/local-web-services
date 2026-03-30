"""Given: an EventBridge event bus has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("an EventBridge event bus has been created")
def events_ddb_bus_has_been_created(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
