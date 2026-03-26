"""When: an EventBridge event bus is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import NeptuneEventsTestClient
from ..constants import TEST_BUS


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = NeptuneEventsTestClient(lws_session)._events.create_event_bus(
            Name=TEST_BUS
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
