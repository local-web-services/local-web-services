"""Given: the EventBridge event bus has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient
from ..constants import TEST_BUS


@given("the EventBridge event bus has been deleted")
def s3api_events_event_bus_has_been_deleted(lws_session):
    try:
        S3apiEventsTestClient(lws_session).create_bus()
    except Exception:
        pass
    S3apiEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
