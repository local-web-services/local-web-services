"""Given: an EventBridge event bus has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given("an EventBridge event bus has been created")
def s3api_events_event_bus_has_been_created(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
