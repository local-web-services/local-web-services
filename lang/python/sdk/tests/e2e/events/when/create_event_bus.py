"""When: an event bus is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import TEST_BUS


@when("an event bus is created")
def create_event_bus(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).create_event_bus(Name=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
