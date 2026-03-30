"""When: an event bus is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when("an event bus is deleted")
def delete_event_bus(lws_session, world):
    try:
        resp = lws_session.client("events").delete_event_bus(Name=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
