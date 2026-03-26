"""When: the EventBridge event bus is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import NeptuneEventsTestClient
from ..constants import TEST_BUS


@when("the EventBridge event bus is deleted")
def delete_event_bus(lws_session, world):
    try:
        world["result"] = NeptuneEventsTestClient(lws_session)._events.delete_event_bus(
            Name=TEST_BUS
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
