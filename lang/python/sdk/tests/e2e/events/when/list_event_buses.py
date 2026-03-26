"""When: all event buses are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient


@when("all event buses are listed")
def list_event_buses(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).list_event_buses()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
