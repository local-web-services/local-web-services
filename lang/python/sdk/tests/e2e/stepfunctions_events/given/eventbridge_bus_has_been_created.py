"""Given: an EventBridge event bus is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsEventsTestClient


@given("an EventBridge event bus is created")
def eventbridge_bus_has_been_created(lws_session):
    StepfunctionsEventsTestClient(lws_session).create_bus()
