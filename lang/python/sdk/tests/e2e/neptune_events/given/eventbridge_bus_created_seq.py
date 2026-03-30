"""Given: an EventBridge event bus has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given("an EventBridge event bus has been created")
def eventbridge_bus_created_seq(lws_session):
    NeptuneEventsTestClient(lws_session).create_bus()
