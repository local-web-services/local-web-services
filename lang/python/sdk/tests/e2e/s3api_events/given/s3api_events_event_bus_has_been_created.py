"""Given: an "eventbridge" "bus" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('an "eventbridge" "bus" is created')
def s3api_events_event_bus_has_been_created(lws_session):
    S3apiEventsTestClient(lws_session).create_bus()
