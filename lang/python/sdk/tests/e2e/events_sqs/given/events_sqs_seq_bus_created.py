"""Given: an EventBridge event bus is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("an EventBridge event bus is created")
def events_sqs_seq_bus_created(lws_session):
    EventsSqsTestClient(lws_session).create_bus()
