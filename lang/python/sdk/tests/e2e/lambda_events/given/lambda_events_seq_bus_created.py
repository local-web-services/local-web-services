"""Given: an EventBridge event bus has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given("an EventBridge event bus has been created")
def lambda_events_seq_bus_created(lws_session):
    try:
        LambdaEventsTestClient(lws_session).create_bus()
    except Exception:
        pass
